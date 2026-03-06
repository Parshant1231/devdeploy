# ── 1. APP SG ────────────────────────────────────
data "http" "my_public_ip" {
    url = "https://icanhazip.com"
}
resource "aws_security_group" "app" {
    vpc_id = var.vpc_id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["${chomp(data.http.my_public_ip.response_body)}/32"] 
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
}


resource "aws_instance" "app" {
    vpc_id        = var.vpc_id
    ami_id        = var.ami_id
    instance_type = var.instance_type

}