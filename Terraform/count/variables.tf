variable "ami_id" {
    type = string 
    default = "ami-0055977a6e828a4f4"
}

variable "environment" {
    default = "DEV"
}

variable "instances_names" {
    type = list
    default = ["mongodb", "mysql", "redis"]
}

variable "zone_id" {
    type = string
    default = "Z0948150OFPSYTNVYZOY" # we are using trainer's zone-id here just for concept understanding 
  
}

variable "domain_name" {
    type = string
    default = "devopsmegham.fun"
}

