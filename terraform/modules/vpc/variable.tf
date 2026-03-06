variable "vpc_cidrs" {
    type = string
}

variable "name_prefix" {
    type = string
}

variable "public_subnet_cidrs" {
    type = list(string)
}

variable "private_subnet_cidrs" {
    type = list(string)
}
