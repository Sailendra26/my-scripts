resource "aws_instance" "ec2-server" {
    count = 3
    ami = var.ami_id
    instance_type = var.environment == "DEV" ? "t3.micro" : "t3.medium"

    tags = {
        Name = var.instances_names[count.index]
    }
}

