variable "vpc_id" {
  description = "VPC ID where the instance security group is created"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the instance is launched"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}

variable "allowed_ports" {
  description = "Ports opened on the EC2 security group"
  type        = list(number)

  validation {
    condition     = length(var.allowed_ports) > 0 && alltrue([for port in var.allowed_ports : port >= 1 && port <= 65535])
    error_message = "allowed_ports must contain valid TCP ports between 1 and 65535."
  }
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to reach the instance"
  type        = list(string)

  validation {
    condition     = length(var.allowed_cidr_blocks) > 0 && alltrue([for cidr in var.allowed_cidr_blocks : can(cidrnetmask(cidr))])
    error_message = "allowed_cidr_blocks must contain valid CIDR blocks."
  }
}

variable "user_data" {
  description = "User data script executed on launch"
  type        = string
  default     = ""
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP with the instance"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags applied to EC2 resources"
  type        = map(string)
  default     = {}
}

