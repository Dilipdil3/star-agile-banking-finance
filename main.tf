provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA2L4SN5M7HCPJSX64"
  secret_key = "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"
}

resource "aws_instance" "my_ec2_instance" {
  ami                          = "ami-0261755bbcb8c4a84"
  instance_type                = "t2.medium"
  key_name                     = "project"
  vpc_security_group_ids       = [aws_security_group.my_security_group.id]
  subnet_id                    = aws_subnet.my_subnet.id
  associate_public_ip_address  = true

  user_data = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt-get update -y
    apt-get install -y docker-ce docker-ce-cli containerd.io
    usermod -aG docker ubuntu
  EOF

  tags = {
    Name = "my-instance"
  }
}

resource "aws_security_group" "my_security_group" {
  name        = "launch-wizard-9"
  description = "Allow all traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id                  = "YOUR_VPC_ID"
  cidr_block              = "10.0.0.0/24"  # Replace with your desired subnet CIDR block
  availability_zone       = "us-east-1a"   # Replace with your desired availability zone
}
