variable "environment" {
  description = "Environment"
}

variable "region" {
  description = "AWS Region"
}

variable "base_cidr" {
  description = "Base CIDR"
}

variable "ssh_source_whitelist" {
  description = "SSH Whitelist IPs"
  type        = list(string)
}
