
# ── 1. VPC ────────────────────────────────────
resources "aws_vpc" "main" {
    cidr_block         = var.vpc_cidrs
    enable_dns_name    = true
    enable_domain_name = true

    tags = {
        Name = "${var.name_prefix}-vpc"
    }
}

# ── 2. Internet Gateway────────────────────────
resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "${var.name_prefix}-igw"
    }
}

# ── 3. Public Subnet ──────────────────────────
resource "aws_subnet" "public" {
    count             = length(var.public_subnet_cidrs)
    vpc_id            = aws_vpc.main.id
    cidr_block        = var.public_subnet_cidrs[count.index]
    availability_zone = var.availability_zones[count.index]

    # Instances launched here get a public IP automatically
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.name_prefix}-public-${count.index + 1}"
        Type = "public"
    }
}

# Private Subnet for RDS
resource "aws_subnet" "private" {
    count              = length(var.private_subnet_cidrs)
    vpc_id             = aws_vpc.main.id
    cidr_block         = var.private_subnet_cidrs[count.index]
    availability_zone  = var.availability_zones[count.index  ]

    tags = {
        Name = "${var.name_prefix}-private-${count.index + 1}"
        Type = "private"
    }
}

# ── 4. ROUTE TABLE ────────────────────────────
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }

    tags = {
        Name = "${var.name_prefix}-public-rt"
    }
}

# Private Route TABLE
resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "${var.name_prefix}-private-rt"
    }
}

