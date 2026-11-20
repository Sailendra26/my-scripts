resource "aws_instance" "ec2-server" {
    ami = var.ami_id
    instance_type = var.instance_type_name
    vpc_security_group_ids = [aws_security_group.my-group.id]

    tags = var.ec2_tags
}


resource "aws_security_group" "my-group" {

    name = var.sg_name # security group name 

    egress {
        from_port        = var.engress_from_port # from port 0 to to port 0 means all ports
        to_port          = var.engress_to_port
        protocol         = var.engress_protocol # -1 means all protocols
        cidr_blocks      = var.engress_cidr # internet
    }

    ingress {
        from_port        = var.ingress_from_port # from port 0 to to port 0 means all ports
        to_port          = var.ingress_to_port
        protocol         = var.ingress_protocol # -1 means all protocols
        cidr_blocks      = var.ingress_cidr # internet
    }

    tags = var.sg_tag_name # this is tage name for the security group
    

}