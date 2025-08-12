module "vpc" {
  source               = "./modules/vpc"
  cluster_name         = var.cluster_name
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
}

module "eks"{
  source = "./modules/eks"
  vpc_id = var.vpc_cidr
  cluster_name = var.cluster_name
  cluster_version = var.cluster_name
  subnet_ids = var.private_subnet_cidrs
  node_groups = var.node_groups
}