resource "aws_instance" "ec2-server" {
    ami = "ami-0055977a6e828a4f4"
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.my-group.id]

    tags = {
        Name = "practice-terraform"
    }
}


resource "aws_security_group" "my-group" {

    name = "terraform-sg" # security group name 

    egress {
        from_port        = 0 # from port 0 to to port 0 means all ports
        to_port          = 0 
        protocol         = "-1" # -1 means all protocols
        cidr_blocks      = ["0.0.0.0/0"] # internet
    }

    ingress {
        from_port        = 0 # from port 0 to to port 0 means all ports
        to_port          = 0 
        protocol         = "-1" # -1 means all protocols
        cidr_blocks      = ["0.0.0.0/0"] # internet
    }

    tags = {

        Name = "my-terr-sg" # this is tage name for the security group
    }

}