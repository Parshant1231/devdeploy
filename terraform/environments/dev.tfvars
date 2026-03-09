# --- Root Values ---
aws_region  = "ap-south-1"
name_prefix = "dev-deploy"



# --- VPC Values ---
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
availability_zones   = ["ap-south-1a", "ap-south-1b"]


# --- EC2 Values ---
key_name  = "myapp-key"
ami_id   = "ami-019715e0d74f695be"
instance_type = "t3.micro"

