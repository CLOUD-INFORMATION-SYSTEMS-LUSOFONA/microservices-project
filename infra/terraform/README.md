# Terraform (Week 8) — Infra Module

Esta pasta contém a versão modularizada da infraestrutura usada no laboratório (VPC, EC2 e RDS), pronta para ser usada no projeto final.

Estrutura
- `main.tf` — composição dos módulos (network, compute, database)
- `variables.tf` — variáveis com validação e inputs sensíveis
- `outputs.tf` — outputs úteis para integração
- `backend.tf` — exemplo comentado de backend remoto (S3 + DynamoDB)
- `modules/` — módulos reusáveis (`vpc`, `ec2`, `rds`)

Como usar (local)

1. Configure as variáveis (ex.: criar `terraform.tfvars` ou usar `-var`):

```hcl
project_name = "CloudComputing"
aws_region   = "eu-central-1"
key_name     = "miguelrodr1"
# db_password should be provided securely (env var or tfvars)
```

2. Inicialize e valide:

```bash
cd infra/terraform
terraform init
terraform fmt -recursive
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

Boas práticas incluídas
- validação de variáveis para CIDRs, portas, tipos de instância
- módulos separados (`vpc`, `ec2`, `rds`) com inputs/outputs
- exemplo de backend remoto (S3) em `backend.tf` — recomenda-se ativar em produção
- uso de workspaces (`terraform.workspace`) para distinguir ambientes

Notas
- Este código foi copiado da versão do laboratório e reorganizado em `infra/terraform`.
- Se utilizar um backend S3, crie o bucket e a tabela DynamoDB antes de habilitar o backend.

