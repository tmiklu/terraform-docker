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

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

resource "random_string" "random" {
  # length, special, upper are arguments
  count   = var.container_count
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
  count = var.container_count
  name  = join("-", ["nodereed", random_string.random[count.index].result])
  image = docker_image.nodered_image.latest

  ports {
    internal = var.int_port
    external = var.ext_port
  }
}



