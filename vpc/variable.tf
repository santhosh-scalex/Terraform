variable "cidr" {
    type = string
    # default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    type = string
    # default = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
    type = string
    # default = "10.0.1.0/24"
 }

variable "internet_cidr"{
    type = string
    # default = "0.0.0.0/0"
}



