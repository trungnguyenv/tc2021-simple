variable "environment" {
  description = "Environment Name"
}

variable "security_groups" {
  description = "Assigned Security Groups"
  type = list(string)
}

variable "public_subnet_id" {
  description = "Public Subnet ID"
}

variable "deployer_key_name" {
  description = "Deployer Key Name"
}
