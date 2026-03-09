# ── 1. APP SG ────────────────────────────────────
data "http" "my_public_ip" {
    url = "https://ipv4.icanhazip.com"
}

locals {
  my_ipv4 = chomp(data.http.my_public_ip.response_body)
}
resource "aws_security_group" "app" {
    vpc_id = var.vpc_id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["${local.my_ipv4}/32"] 
    }

    ingress {
        description = "HTTP from internet"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] 
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "${var.name_prefix}-app-sg"
    }
}

# ── 2. APP  ────────────────────────────────────
resource "aws_instance" "app" {
    ami           = var.ami_id
    instance_type = var.instance_type
    key_name      = var.key_name
    subnet_id     = var.public_subnet_id
    security_groups = [aws_security_group.app.id]

    root_block_device {
        volume_size = 20
        volume_type = "gp3"
    }

    # Install Docker automatically (Ubuntu Syntax)
    user_data = <<-EOF
        #!/bin/bash
        # Update the package database
        apt-get update -y
        apt-get upgrade -y

        # Install Docker using the official Ubuntu repository
        apt-get install -y docker.io

        # Start and enable Docker service
        systemctl start docker
        systemctl enable docker

        # Add the default ubuntu user to the docker group
        # Note: On Ubuntu, the default user is 'ubuntu', not 'ec2-user'
        usermod -aG docker ubuntu
    EOF

    tags = {
        Name = "${var.name_prefix}-app"
    }
}

#3 Elastic IP - gives EC2 a fixed public IP
resource "aws_eip" "app" {
    instance = aws_instance.app.id
    domain   = "vpc"

    tags = {
        Name = "${var.name_prefix}-eip"
    }
}