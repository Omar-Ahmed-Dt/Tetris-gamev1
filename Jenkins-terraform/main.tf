data "aws_ami" "ubuntu" {

  filter {
    name   = "image-id"
    values = ["ami-03f4878755434977f"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "Jenkins-server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.small"
  key_name               = "enkidu"
  vpc_security_group_ids = [aws_security_group.Jenkins-sg.id]
  user_data              = templatefile("./install_jenkins.sh", {})
  iam_instance_profile   = aws_iam_instance_profile.Jenkins-terraform-profile.name

  tags = {
    Name = "Jenkins Server"
  }

}

resource "aws_instance" "Jenkins-agent" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.medium"
  key_name               = "enkidu"
  vpc_security_group_ids = [aws_security_group.Jenkins-agent-sg.id]
  user_data              = templatefile("./install_jenkins-agent.sh", {})
  iam_instance_profile   = aws_iam_instance_profile.Jenkins-terraform-profile.name

  tags = {
    Name = "Jenkins agent"
  }

  root_block_device {
    volume_size = 30
  }
}
