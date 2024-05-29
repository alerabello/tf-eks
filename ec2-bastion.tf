module "ec2-instance" {
  # Dependencia do modulo EKS para criar a instancia EC2.
  depends_on = [ module.eks ]

  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.6.1"
  name = "ec2-bastion-eks"
  ami = ""
  instance_type = "t3a.medium"
  key_name = "bastion-key-eks"
  monitoring = true
  vpc_security_group_ids = ""
  subnet_id = ""
  associate_public_ip_address = false
  iam_instance_profile = "AMZ-SSM-Monitoring"
  user_data = file("init.sh")

  volume_tags = {
    Name = "ec2-bastion-eks"
  }

  root_block_device = [
    {
      volume_type = "gp3"
      volume_size = 30
      encrypted = true
    }
  ]
  tags = {
    Name = "ec2-bastion-eks"
    terraform = "true"
    Environment = "Development"
  }
}