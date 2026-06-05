# Week 8 Terraform Refactor

This folder contains a modularized version of the Week 7 infrastructure.

## Structure

- `main.tf` - root composition, provider, data sources, and module calls
- `variables.tf` - input variables with validation and sensitive values
- `outputs.tf` - root outputs for network, compute, and database
- `terraform.tfvars` - non-secret default values
- `modules/vpc` - reusable VPC module
- `modules/ec2` - reusable EC2 module with dynamic security group rules
- `modules/rds` - reusable RDS module

## Inputs

Main inputs are:

- `aws_region`
- `vpc_cidr`
- `azs`
- `public_subnet_cidrs`
- `private_subnet_cidrs`
- `instance_type`
- `key_name`
- `allowed_ports`
- `allowed_cidr_blocks`
- `db_name`
- `db_username`
- `db_password` (sensitive)

## Outputs

Root outputs include:

- `network_vpc_id`
- `network_public_subnet_ids`
- `network_private_subnet_ids`
- `compute_instance_id`
- `compute_public_ip`
- `compute_public_dns`
- `database_instance_id`
- `database_endpoint`

## Workspaces

The configuration is workspace-aware. Resource names and tags include the current workspace.

Example:

```powershell
terraform workspace new dev
terraform workspace new staging
terraform workspace new prod
```

## How to run

Use PowerShell and set the database password as an environment variable:

```powershell
$env:TF_VAR_db_password = "your-secure-password"
terraform init
terraform fmt -recursive
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

## Notes

- `terraform.tfvars` contains only non-secret values.
- Validation blocks provide clear errors for invalid CIDRs, ports, and instance types.
- The EC2 security group uses a dynamic `ingress` block driven by `allowed_ports`.
- The VPC module uses `for_each` for subnet and route table associations.

