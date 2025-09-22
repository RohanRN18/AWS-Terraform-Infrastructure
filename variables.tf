variable "aws_region" {
    default = "ap-south-1"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "ami_id" {
    default = "ami-1234567890"  
}

variable "ec2_key" {
    description = "Key for SSH into EC2"
    default = "linux-1" 
}

variable "allow_ssh_cidr" {
    description = "Allow CIDR to SSH"
    default = "0.0.0.0/0"

}
