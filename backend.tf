terraform {
  backend "s3" {
    bucket = "rohan-buck-1"
    key = "arn:aws:s3:::my-bucket-name"
    region = "ap-south-1"
  }

}
