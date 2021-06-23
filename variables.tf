variable "env" {
  type    = string
  default = "dev"
}

variable "image" {
  type        = map(any)
  description = "Image for container"
  default = {
    dev  = "nodered/node-red:latest"
    prod = "nodered/node-red:latest-minimal"
  }
}


variable "ext_port" {
  type = list(any)
  #default = 1880

  validation {
    condition     = max(var.ext_port...) <= 65535 && min(var.ext_port...) > 1024
    error_message = "Port must be set between 1024 and 65535."
  }
}


variable "int_port" {
  type    = number
  default = 1880

  validation {
    #condition     = can(regex(1880, var.int_port))
    condition     = var.int_port == 1880
    error_message = "Internal port must be 1880."
  }
}

locals {
  container_count = length(var.ext_port)
}
