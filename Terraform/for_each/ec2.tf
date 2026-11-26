resource "aws_instance" "ec2-server"{
    for_each = var.instances
    ami = var.ami_id
    instance_type = each.value

    tags = {
        Name = each.key
    }



}