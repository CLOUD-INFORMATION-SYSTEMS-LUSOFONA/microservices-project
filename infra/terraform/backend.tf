terraform {
    backend "s3" {
      bucket         = "my-terraform-state-bucket"
      key            = "project/terraform.tfstate"
      region         = "eu-central-1"
      dynamodb_table = "terraform-locks"
      encrypt        = true
    }
  }