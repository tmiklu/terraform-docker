variable "ext_port" {
  type    = number
  #default = 1880

  validation {
    condition =  var.ext_port <= 65535 && var.ext_port >= 1024
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

variable "container_count" {
  type    = number
  default = 1
}