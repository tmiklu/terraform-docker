output "name" {
  value       = docker_container.nodered_container[0].name
  sensitive   = false
  description = "description"
}

output "ip" {
  value       = join(":", [docker_container.nodered_container[0].ip_address, docker_container.nodered_container[0].ports[0].external])
  sensitive   = false
  description = "description"
}