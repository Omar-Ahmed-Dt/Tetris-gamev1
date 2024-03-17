terraform {
  backend "s3" {
    bucket = "enkidu1234bucket"
    key    = "Jenkins/terraform.tfstate"
    region = "ap-south-1"
  }
}
