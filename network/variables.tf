variable "environment" {
  description = "Environment Name"
}

variable "base_cidr" {
  description = "Base CIDR for VPC"
}

variable "ssh_source_whitelist" {
  description = "SSH Whitelist IPs"
  type        = list(string)
}
