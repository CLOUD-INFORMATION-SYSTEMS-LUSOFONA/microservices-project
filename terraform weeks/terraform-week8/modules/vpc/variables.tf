variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "vpc_cidr must be a valid CIDR block."
  }
}

variable "azs" {
  description = "Availability zones for subnet placement"
  type        = list(string)

  validation {
    condition     = length(var.azs) >= 2
    error_message = "azs must contain at least two availability zones."
  }
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDR blocks"
  type        = list(string)

  validation {
    condition = length(var.public_subnet_cidrs) == length(var.azs) && alltrue([
      for cidr in var.public_subnet_cidrs : can(cidrnetmask(cidr))
    ])
    error_message = "public_subnet_cidrs must contain one valid CIDR per AZ."
  }
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDR blocks"
  type        = list(string)

  validation {
    condition = length(var.private_subnet_cidrs) == length(var.azs) && alltrue([
      for cidr in var.private_subnet_cidrs : can(cidrnetmask(cidr))
    ])
    error_message = "private_subnet_cidrs must contain one valid CIDR per AZ."
  }
}

variable "tags" {
  description = "Tags applied to network resources"
  type        = map(string)
  default     = {}
}

