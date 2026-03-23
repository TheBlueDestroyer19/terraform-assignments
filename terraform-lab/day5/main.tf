terraform {
  required_version = ">= 1.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

provider "local" {}

# Variables
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "file_count" {
  description = "Number of files to create"
  type        = number
  default     = 3
}

variable "base_message" {
  description = "Base message for files"
  type        = string
  default     = "Terraform CI Test"
}

# Create multiple files
resource "local_file" "test_files" {
  count = var.file_count

  filename = "${path.module}/${var.environment}_file_${count.index + 1}.txt"
  content  = "${var.base_message} - File ${count.index + 1}"
}

# Output all file paths
output "created_files" {
  description = "List of created file paths"
  value       = local_file.test_files[*].filename
}

# Output summary
output "summary" {
  value = "Created ${var.file_count} files for ${var.environment} environment"
}
