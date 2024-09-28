#vpc
module "eks_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "eks-vpc"
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.azs.names
  
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  tags = {
    Name = "eks-terraform-vpc"
    Terraform = "true"
    Environment = "dev"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "eks-cluster"
  cluster_version = "1.30"

  vpc_id                   = module.eks_vpc.vpc_id
  subnet_ids               = module.eks_vpc.private_subnets

  eks_managed_node_groups = {
    node = {
        min_size = 1
        max_size = 3
        desired_size = 2
        instance_type = ["t2.micro"]
        
    }
  }

  
  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
