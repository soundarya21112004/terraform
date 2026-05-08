# 1. Private Key generate pannuvom
resource "tls_private_key" "rsa_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# 2. AWS-la Key Pair create pannuvom
resource "aws_key_pair" "tf_key" {
  key_name   = "common"
  public_key = tls_private_key.rsa_key.public_key_openssh
}

# 3. Private key-ah .pem file-ah save pannuvom (Unga folder-la create aagum)
resource "local_file" "tf_key_file" {
  content  = tls_private_key.rsa_key.private_key_pem
  filename = "common.pem"
}

# 4. Module call pannuvom
module "my_ec2" {
  source   = "./modules/ec2_instance"
  key_name = aws_key_pair.tf_key.key_name
}