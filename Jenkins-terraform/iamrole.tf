resource "aws_iam_role" "Jenkins-terraform-role" {
  name = "Jenkins-terraform"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "Jenkins-terraform-role"
  }
}

resource "aws_iam_role_policy_attachment" "Jenkins-terraform-attach" {
  role       = aws_iam_role.Jenkins-terraform-role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "Jenkins-terraform-profile" {
  name = "Jenkins-terraform-profile"
  role = aws_iam_role.Jenkins-terraform-role.name
}
