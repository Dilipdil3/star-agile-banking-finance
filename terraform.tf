provider "aws" { 
 region = "us-east-1" 
 access_key = "abc" 
 secret_key = "abc" 
} 
resource "aws_instance" "my_ec2_instance" { 
 ami = "ami-0c94855ba95c71c99" 
 instance_type = "t2.micro" 
 key_name = "pemfile" 
 tags ={ 
 name="Terraform hands-on" 
} 
}
