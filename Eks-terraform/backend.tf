terraform {
  backend "s3" {
    bucket = "enkidu1234bucket"
    key    = "EKS-tf/terraform.tfstate"
    region = "ap-south-1"
  }
}
