resource "aws_instance" "example_instance" {
  ami           = "ami-008fe2fc65df48dac"  
  instance_type = "t2.micro"  
    key_name      = "jenkins"
  tags = {
    Name = "jenkins-server"
    createdBy = "terraform"

  }

  vpc_security_group_ids = [aws_security_group.example_sg.id]

}

resource "aws_key_pair" "example_key_pair" {
  key_name   = "jenkins"
  public_key = file("~/Desktop/keypairs/jenkins.pub")  # Use the path to your generated public key file

  tags = {
    Name = "jenkins",
    createdBy = "terraform"
  }
}

resource "aws_security_group" "example_sg" {
  name        = "jenkins-sg"
  description = "Allow inbound SSH traffic on port 22"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open to all sources, you may want to restrict this to specific IPs
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open to all sources, you may want to restrict this to specific IPs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic, you may want to restrict this based on your requirements
  }
}
