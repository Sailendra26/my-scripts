variable "ami_id" {
    type = string 
    default = "ami-0055977a6e828a4f4"
}

variable "ec2-tags" {
    type = map 
    default = {
        Name = "practice-terraform"
    }
}

# Condition 

variable "environment" {
    type = string
    default = "DEV"
}