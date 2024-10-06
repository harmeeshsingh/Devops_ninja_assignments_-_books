/*--------------- VPC ---------------*/

data "aws_availability_zones" "available" {}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.vpc_enable_dns_support
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  tags = var.vpc_tags
}

/*--------------- Public Subnets ---------------*/

resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnets_cidr)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnets_cidr[count.index]
  availability_zone       = "${var.aws_region}${element(["a", "b"], count.index % 2)}"
  map_public_ip_on_launch = var.enable_map_public_ip_on_launch
  tags = {
  Name = "${var.public_subnets_tags[count.index]["Name"]}-${element(data.aws_availability_zones.available.names, count.index % 2)}"
}

}

/*--------------- Private Subnets ---------------*/

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnets_cidr)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnets_cidr[count.index]
  availability_zone = "${var.aws_region}${element(["a", "b"], count.index % 2)}"
  tags = {
  Name = "${var.private_subnets_tags[count.index]["Name"]}-${element(data.aws_availability_zones.available.names, count.index % 2)}"
}
}


/*--------------- # Internet Gateway ---------------*/

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = var.igw_tags
}

/*--------------- Elastic IP ---------------*/

resource "aws_eip" "elastic_ip" {
  count  = var.elastic_ip
  domain = "vpc"
}

/*--------------- NAT Gateway ---------------*/

resource "aws_nat_gateway" "nat" {
  count         = var.nat
  allocation_id = aws_eip.elastic_ip[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index % length(aws_subnet.public_subnets)].id
  tags = {
  Name = "${var.nat_tags[count.index]["Name"]}-${element(data.aws_availability_zones.available.names, count.index % 2)}"
}
  depends_on  = [aws_eip.elastic_ip]
}

/*--------------- Public Route Table ---------------*/

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = var.public_route_table_tags
}

/*--------------- Public RTB Association ---------------*/

resource "aws_route_table_association" "public_route_association01" {
  count = length(aws_subnet.public_subnets.*.id)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rtb.id
}
/*--------------- Private RTB ---------------*/

resource "aws_route_table" "private_rtb" {
  count  = var.nat
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = var.vpc_cidr
    gateway_id = "local"
  }
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }
  tags = {
  Name = "${var.private_route_table_tags[count.index]["Name"]}-${element(data.aws_availability_zones.available.names, count.index % 2)}"
}
  depends_on = [aws_nat_gateway.nat]
}

/*--------------- Private RTB Association ---------------*/


resource "aws_route_table_association" "private_route_association01" {
  count          = length(var.specific_subnet_AZ01)
  subnet_id      = aws_subnet.private_subnets[var.specific_subnet_AZ01[count.index]].id
  route_table_id = aws_route_table.private_rtb[0].id
  depends_on     = [aws_route_table.private_rtb]
}

resource "aws_route_table_association" "private_route_association02" {
  count          = length(var.specific_subnet_AZ02)
  subnet_id      = aws_subnet.private_subnets[var.specific_subnet_AZ02[count.index]].id
  route_table_id = aws_route_table.private_rtb[1].id
  depends_on     = [aws_route_table.private_rtb]
}

/*--------------- Frontend NACL ---------------*/

resource "aws_network_acl" "frontend_nacl" {
  vpc_id = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = var.frontend_nacl_ingress
    content {
      protocol   = ingress.value.protocol
      rule_no    = ingress.value.rule_no
      action     = ingress.value.action
      cidr_block = ingress.value.cidr_block
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
    }
  }
  dynamic "egress" {
    for_each = var.frontend_nacl_egress
    content {
      protocol   = egress.value.protocol
      rule_no    = egress.value.rule_no
      action     = egress.value.action
      cidr_block = egress.value.cidr_block
      from_port  = egress.value.from_port
      to_port    = egress.value.to_port
    }
  }
  tags = var.frontend_nacl_tags
}
/*--------------- Frontend NACL Subnet Association ---------------*/

resource "aws_network_acl_association" "frontend_nacl_subnet1" {
  network_acl_id = aws_network_acl.frontend_nacl.id
  subnet_id      = aws_subnet.private_subnets[0].id
}

resource "aws_network_acl_association" "frontend_nacl_subnet2" {
  network_acl_id = aws_network_acl.frontend_nacl.id
  subnet_id      = aws_subnet.private_subnets[1].id
}

/*--------------- Backend NACL ---------------*/

resource "aws_network_acl" "backend_nacl" {
  vpc_id = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = var.backend_nacl_ingress
    content {
      protocol   = ingress.value.protocol
      rule_no    = ingress.value.rule_no
      action     = ingress.value.action
      cidr_block = ingress.value.cidr_block
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
    }
  }
  dynamic "egress" {
    for_each = var.backend_nacl_egress
    content {
      protocol   = egress.value.protocol
      rule_no    = egress.value.rule_no
      action     = egress.value.action
      cidr_block = egress.value.cidr_block
      from_port  = egress.value.from_port
      to_port    = egress.value.to_port
    }
  }
  tags = var.backend_nacl_tags
}
/*--------------- Backend NACL Subnet Association ---------------*/

resource "aws_network_acl_association" "backend_nacl_assc" {
  network_acl_id = aws_network_acl.backend_nacl.id
  subnet_id      = aws_subnet.private_subnets[2].id
}

resource "aws_network_acl_association" "backend_nacl_assc_2" {
  network_acl_id = aws_network_acl.backend_nacl.id
  subnet_id      = aws_subnet.private_subnets[3].id
}


/*--------------- Database NACL ---------------*/

resource "aws_network_acl" "db_nacl" {
  vpc_id = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = var.db_nacl_ingress
    content {
      protocol   = ingress.value.protocol
      rule_no    = ingress.value.rule_no
      action     = ingress.value.action
      cidr_block = ingress.value.cidr_block
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
    }
  }
  dynamic "egress" {
    for_each = var.db_nacl_egress
    content {
      protocol   = egress.value.protocol
      rule_no    = egress.value.rule_no
      action     = egress.value.action
      cidr_block = egress.value.cidr_block
      from_port  = egress.value.from_port
      to_port    = egress.value.to_port
    }
  }
  tags = var.db_nacl_tags
}
/*--------------- Database NACL Subnet Association ---------------*/

resource "aws_network_acl_association" "db_nacl_assc" {
  network_acl_id = aws_network_acl.db_nacl.id
  subnet_id      = aws_subnet.private_subnets[4].id
}

resource "aws_network_acl_association" "db_nacl_assc_2" {
  network_acl_id = aws_network_acl.db_nacl.id
  subnet_id      = aws_subnet.private_subnets[5].id
}


/*--------------- ALB Security Group ---------------*/


resource "aws_security_group" "alb_sg" {
  name        = var.alb_sg_name
  description = var.alb_sg_description
  vpc_id      = aws_vpc.vpc.id

  dynamic "ingress" {
    for_each = var.alb_sg_inbound_rules
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = [ingress.value.source]
    }
  }

  dynamic "egress" {
    for_each = var.alb_sg_outbound_rules
    content {
      from_port       = egress.value.port
      to_port         = egress.value.port
      protocol        = egress.value.protocol
      cidr_blocks     = [egress.value.source]
    }
  }
  tags = var.alb_sg_tags
}

/*--------------- ALB ---------------*/

resource "aws_lb" "alb" {
  name               = var.alb_name
  internal           = var.alb_internal
  load_balancer_type = var.alb_type
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [for subnet in aws_subnet.public_subnets : subnet.id]

  # enable_deletion_protection = var.alb_deletion_protection

  tags = var.alb_tags
}

/*--------------- ALB Listener ---------------*/

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.alb_listener_port
  protocol          = var.alb_listener_protocol
  
  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Dummy response"
      status_code  = "200"
    }
  }
}


/*--------------- Route 53   ---------------*/

resource "aws_route53_zone" "route53_zone" {
 name = var.route53_zone_name
 vpc {
   vpc_id = aws_vpc.vpc.id
   vpc_region = var.region
 }
 tags = var.route53_zone_tags
}

resource "aws_route53_record" "route53_record" {
  zone_id = aws_route53_zone.route53_zone.id
  name    = "example.com"
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}
