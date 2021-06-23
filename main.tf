#specify providers
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.7"
    }
  }
}

provider "docker" {}

resource "null_resource" "docker_vol" {

  provisioner "local-exec" {
    command = "mkdir noderedvol/ || true && sudo chown -R 1000:1000 noderedvol/"
    #command = "sudo bash"
  }
}


resource "docker_image" "nodered_image" {
  # curly braces {} are required only if you set map first time, var.image is already map
  name = lookup(var.image, var.env)
}

resource "random_string" "random" {
  # length, special, upper are arguments
  count   = local.container_count
  length  = 4
  special = false
  upper   = false
}

/* count ma vzdy index []

❯ terraform state list
docker_container.nodered_container[0]
docker_image.nodered_image
random_string.random[0]

*/

resource "docker_container" "nodered_container" {
  count = local.container_count
  name  = join("-", ["nodereed", random_string.random[count.index].result])
  image = docker_image.nodered_image.latest

  ports {
    internal = var.int_port
    external = var.ext_port[count.index]
  }

  volumes {
    container_path = "/data"
    host_path      = "${path.cwd}/noderedvol"
  }
}



