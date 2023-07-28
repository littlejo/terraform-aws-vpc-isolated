module "vpc" {
  source     = "../../"
  cidr_block = "10.0.0.0/16"
  name       = "vpc-terraform-test"

  subnets = {
    private_a = { #=> a => az letter
      name       = "private-a"
      cidr_block = "10.0.0.0/24"
    }
    private_b = { #=> b => az letter
      name       = "private-b"
      cidr_block = "10.0.1.0/24"
    }
    tgw_a = {
      name       = "tgw-a"
      cidr_block = "10.0.2.0/24"
    }
    tgw_b = {
      name       = "tgw-b"
      cidr_block = "10.0.3.0/24"
    }
  }
}
