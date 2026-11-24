resource "aws_instance" "ec2-server" {
    ami = var.ami_id
    instance_type = var.environment == "PROD" ? "t3.medium" : "t3.micro"

    tags = var.ec2-tags
}

