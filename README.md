# devdeploy

A Terraform project for provisioning AWS infrastructure, including a Virtual Private Cloud (VPC) and EC2 instances.

## Overview

This repository provides reusable Terraform modules to deploy a production-ready AWS environment with:

- **VPC** – custom CIDR, public and private subnets, internet gateway, and route tables
- **EC2** – application instance with a security group that allows SSH (from your IP only) and HTTP traffic

## Repository Structure

```
terraform/
├── main.tf              # Root module – wires together the VPC and EC2 modules
├── variables.tf         # Input variables for the root module
├── outputs.tf           # Outputs exposed by the root module
├── versions.tf          # Terraform and provider version constraints
└── modules/
    ├── vpc/
    │   ├── main.tf      # VPC, subnets, internet gateway, and route tables
    │   ├── variable.tf  # Input variables for the VPC module
    │   └── outputs.tf   # Outputs (e.g. VPC ID, subnet IDs)
    └── ec2/
        └── main.tf      # Security group and EC2 instance resources
```

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.3.0
- An AWS account with credentials configured (via environment variables, `~/.aws/credentials`, or an IAM role)

## Usage

1. **Clone the repository**

   ```bash
   git clone https://github.com/Parshant1231/devdeploy.git
   cd devdeploy/terraform
   ```

2. **Initialize Terraform**

   ```bash
   terraform init
   ```

3. **Create a variables file** (e.g. `terraform.tfvars`)

   ```hcl
   aws_region = "us-east-1"
   ```

4. **Review the execution plan**

   ```bash
   terraform plan
   ```

5. **Apply the configuration**

   ```bash
   terraform apply
   ```

6. **Destroy resources when done**

   ```bash
   terraform destroy
   ```

## Inputs

| Name         | Description      | Type   | Required |
|--------------|------------------|--------|----------|
| `aws_region` | AWS region       | string | yes      |

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the [MIT License](LICENSE).
