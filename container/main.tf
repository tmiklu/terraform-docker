resource "docker_container" "nodered_container" {
  name = name_in
  # access image output from module image
  image = var.image_in

  ports {
    internal = var.int_port
    external = var.ext_port[terraform.workspace][count.index]
  }

  volumes {
    container_path = "/data"
    host_path      = "${path.cwd}/noderedvol"
  }
}