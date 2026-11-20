variable "ami_id" {
    type = string
    default = "ami-0055977a6e828a4f4"
}

variable "instance_type_name" {
    type = string
    default = "t3.micro"
}


variable "ec2_tags" {
    type = map
    default = {
        Name = "practice-terraform"
        Description = "terraform ec2 server"
    }

}

variable "sg_name" {
    type = string
    default = "terraform-sg"
}

variable "engress_from_port" {
    type = number
    default = 0
}

variable "engress_to_port" {
    type = number
    default = 0
}

variable "engress_protocol" {
    type = string
    default = -1
}

variable "engress_cidr" {
    type = list
    default = ["0.0.0.0/0"] # internet
}

variable "ingress_from_port" {
    type = number
    default = 0
}

variable "ingress_to_port" {
    type = number 
    default =  0
}

variable "ingress_protocol" {
    type = string
    default = "-1"
}

variable "ingress_cidr" {
    type = list
    default = ["0.0.0.0/0"] # internet
}

variable "sg_tag_name" {
    type = map
    default = {
        Name = "my-terr-sg"
        description = "security group tag name"
    }

  
}