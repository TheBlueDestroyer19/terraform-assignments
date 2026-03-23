terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# First container
module "nginx1" {
  source = "./modules/nginx_container"

  container_name = "nginx-1"
  container_port = 8081
  image_name     = "nginx:latest"
}

# Second container
module "nginx2" {
  source = "./modules/nginx_container"

  container_name = "nginx-2"
  container_port = 8082
  image_name     = "nginx:latest"
}

# Output
output "urls" {
  value = [
    "http://localhost:8081",
    "http://localhost:8082"
  ]
}
