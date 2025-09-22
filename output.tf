output "vpc_id" {
    description = "VPC ID"
    value = aws_vpc.My_VPC.id
}
output "public_subnet_id" {
    description = "Public Subnet Id"
    value = aws_subnet.pub_sub  
}
output "private_subnet_id" {
    description = "Private Subnet Id 1"
    value = [aws_subnet.pri_sub1.id , aws_subnet.pri_sub2.id ]
}
output "EC2_Instance_ID" {
    description = "EC2 Instance ID"
    value = aws_instance.MyEC2.id  
}
output "EC2_public_ip" {
    description = "EC2 public IP address"
    value = aws_instance.MyEC2.public_ip  
}