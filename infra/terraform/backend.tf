terraform {
  backend "s3" {
    # ------------------------------------------------------------
    # IMPORTANT:
    # Replace the values below with your own S3 bucket details.
    # This project does NOT include a bucket name for security.
    #
    # Example:
    # bucket = "my-terraform-state-bucket"
    # key    = "enterprise-app/terraform.tfstate"
    # region = "eu-west-2"
    # ------------------------------------------------------------

    bucket = "<your-s3-bucket-name>"
    key    = "enterprise-app/terraform.tfstate"
    region = "<your-aws-region>"
  }
}
