terraform {
    backend "s3" {
        bucket = "sabeerz-website"
        key = "terraform/terraform-excercise-1.tfstate" 
        region = "us-east-1"
    }
}
