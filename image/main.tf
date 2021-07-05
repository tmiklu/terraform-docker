resource "docker_image" "nodered_image" {
  # curly braces {} are required only if you set map first time, var.image is already map
  name = var.image_in
}