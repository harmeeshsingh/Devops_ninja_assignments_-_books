resource "aws_vpc" "vpc_one" {
  cidr_block       = var.vpc_cidr
  tags = {
     Name = var.vpc
   }
}