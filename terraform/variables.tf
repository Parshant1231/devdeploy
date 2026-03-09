# ─── Root Variables ───────────────────────────
variable "aws_region" {
    description = "Aws region"
    type        = string
}

variable "name_prefix" {
    type = string
}

# ─── VPC Variables ───────────────────────────
variable "vpc_cidr" {
    type = string
}

variable "public_subnet_cidrs" {
    type = list(string)
}

variable "private_subnet_cidrs" {
    type = list(string)
}

variable "availability_zones" {
    type = list(string)
}

variable "ami_id" {
    type = string
}

variable "instance_type" {
    type = string
}

# ─── EC2 Variables ───────────────────────────
variable "key_name" {
    type = string
}
