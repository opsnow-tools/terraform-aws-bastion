# bastion

terraform {
  backend "s3" {
    region = "cn-north-1"
    bucket = "beijing-dev-sre-state"
    key    = "bastion-skc2.tfstate"
  }
  required_version = ">= 0.12"
}

provider "aws" {
  region = "cn-north-1"
}

module "bastion" {
  source = "../../modules/bastion-cn"

  region = "cn-north-1"
  city   = "BEIJING"
  stage  = "SRE"
  name   = "SKC2"
  suffix = "BASTION"

  # beijing 에서는 owner id 가 달라서 직접 찾은 AMI 로 명시
  ami_id = "ami-0242c2cc3f754a0e9"

  # beijing BEIJING-DEV-SKC1 VPC
  vpc_id = "vpc-009ab7e55de11a28b"

  # beijing BEIJING-A-DEV-SKC1-PUBLIC
  subnet_id = "subnet-0f7e82c59e75c7163"

  # ami_id = ""
  type = "t3.nano"

  key_name = "BEIJING-SRE-SKC2-BASTION"

  allow_ip_address = [
    "58.151.93.2/32", # 강남 echo "$(curl -sL icanhazip.com)/32"
    "58.151.93.9/32", # 강남 echo "$(curl -sL icanhazip.com)/32"
  ]
}

output "name" {
  value = module.bastion.name
}

output "key_name" {
  value = module.bastion.key_name
}

output "public_ip" {
  value = module.bastion.public_ip
}
