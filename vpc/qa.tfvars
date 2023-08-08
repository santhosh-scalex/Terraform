region = "us-west-2"

vpc_name = "ss-qa"
vpc_cidr_block =  "10.0.0.0/16"
public_subnets  = ["10.0.1.0/24","10.0.2.0/24"]
private_subnets = ["10.0.3.0/24","10.0.4.0/24","10.0.10.0/24","10.0.11.0/24"]
database_subnets    = ["10.0.5.0/24","10.0.6.0/24"]
azs = ["us-west-2a", "us-west-2b"]

tags = { 
  Environment = "qa"
}
