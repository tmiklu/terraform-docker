resource "null_resource" "docker_vol" {

  provisioner "local-exec" {
    command = "mkdir noderedvol/ || true && sudo chown -R 1000:1000 noderedvol/"
    #command = "sudo bash"
  }
}

module "image" {
  source   = "./image"
  image_in = var.image[terraform.workspace]
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

module "container" {
  source     = "./container"
  depends_on = [null_resource.docker_vol]
  count      = local.container_count
  name_in    = join("-", ["nodereed", terraform.workspace, random_string.random[count.index].result])
  # access image output from module image
  image_in = module.image.image_out

  ports {
    internal = var.int_port
    external = var.ext_port[terraform.workspace][count.index]
  }

  volumes {
    container_path = "/data"
    host_path      = "${path.cwd}/noderedvol"
  }
}



