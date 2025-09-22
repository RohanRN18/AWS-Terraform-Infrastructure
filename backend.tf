terraform {
  backend "s3" {
    bucket = "rohan-buck-1"
    key = "arn:aws:s3:::rohan-buck-1"
    region = "ap-south-1"
  }
}