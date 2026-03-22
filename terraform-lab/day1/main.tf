terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

provider "local" {}

# Variable
variable "message" {
  description = "Message to write into the file"
  type        = string
  default     = "Hello from Terraform"
}

# Resource
resource "local_file" "hello" {
  filename = "${path.module}/hello.txt"
  content  = var.message
}

# Output
output "file_path" {
  description = "Path of the created file"
  value       = local_file.hello.filename
}
