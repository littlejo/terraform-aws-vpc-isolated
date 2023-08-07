module "vpc" {
  source     = "../../"
  cidr_block = "10.0.0.0/16"
  name       = "vpc-terraform-test"

  subnets = {
    private_a = { #=> a => az letter
      name       = "sub-private-a"
      cidr_block = "10.0.0.0/24"
    }
    private_b = { #=> b => az letter
      name       = "sub-private-b"
      cidr_block = "10.0.1.0/24"
    }
    tgw_a = {
      name       = "sub-tgw-a"
      cidr_block = "10.0.2.0/24"
    }
    tgw_b = {
      name       = "sub-tgw-b"
      cidr_block = "10.0.3.0/24"
    }
  }

  security_groups = {
    test = {
      name        = "test"
      description = "test"
      ingress = [
        {
          description = "ssh"
          port        = 22
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
    }
  }
}
