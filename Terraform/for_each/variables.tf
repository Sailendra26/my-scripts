variable "instances" {
    type = map 
    default = {
        mongodb = "t3.micro"
        redis = "t3.micro"
        mysql = "t3.small"
    }
}

variable "ami_id" {
    type = string
    default = "Z0948150OFPSYTNVYZOY" # we are using trainer's zone-id here just for concept understanding 
}

variable "zone_id" {
    type = string
    default = "Z0948150OFPSYTNVYZOY" # we are using trainer's zone-id here just for concept understanding 
}

variable "domain_name" {
    type = string
    default = "devopsmegham.fun"
  
}