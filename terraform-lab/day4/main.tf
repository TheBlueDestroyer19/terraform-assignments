terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# Dynamic container configuration
variable "container_config" {
  description = "List of container configurations"
  type = list(object({
    name = string
    port = number
  }))

  default = [
    {
      name = "web1"
      port = 8081
    },
    {
      name = "web2"
      port = 8082
    },
    {
      name = "web3"
      port = 8083
    },
    {
      name = "web4"
      port = 8084
    }
  ]
}

# Convert list → map for for_each
locals {
  containers = {
    for c in var.container_config :
    c.name => c
  }
}

# Dynamic module creation
module "nginx_containers" {
  source = "./modules/nginx_container"

  for_each = local.containers

  container_name = each.value.name
  container_port = each.value.port
  image_name     = "nginx:latest"
}

# Output URLs
output "container_urls" {
  value = [
    for c in var.container_config :
    "http://localhost:${c.port}"
  ]
}
