terraform {
  # Uncomment and update bucket/key values once you've created the S3 bucket and DynamoDB table
  # Reference: scripts/bootstrap-terraform-backend.ps1
  #
  # backend "s3" {
  #   bucket         = "my-terraform-state-bucket"
  #   key            = "project/terraform.tfstate"
  #   region         = "eu-central-1"
  #   dynamodb_table = "terraform-locks"
  #   encrypt        = true
  # }

  # For local development, uses local state file:
}