output "workspace" {
  description = "Terraform workspace in use"
  value       = terraform.workspace
}

output "network_vpc_id" {
  description = "VPC ID created by the network module"
  value       = module.network.vpc_id
}

output "network_public_subnet_ids" {
  description = "Public subnet IDs created by the network module"
  value       = module.network.public_subnet_ids
}

output "network_private_subnet_ids" {
  description = "Private subnet IDs created by the network module"
  value       = module.network.private_subnet_ids
}

output "compute_instance_id" {
  description = "EC2 instance ID"
  value       = module.compute.instance_id
}

output "compute_public_ip" {
  description = "EC2 public IP"
  value       = module.compute.public_ip
}

output "compute_public_dns" {
  description = "EC2 public DNS"
  value       = module.compute.public_dns
}

output "compute_security_group_id" {
  description = "EC2 security group ID"
  value       = module.compute.security_group_id
}

output "database_instance_id" {
  description = "RDS instance ID"
  value       = module.database.instance_id
}

output "database_endpoint" {
  description = "RDS endpoint"
  value       = module.database.endpoint
}

output "database_port" {
  description = "RDS port"
  value       = module.database.port
}

