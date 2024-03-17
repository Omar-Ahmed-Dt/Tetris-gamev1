output "ip-jenkins-server" {
  value = aws_instance.Jenkins-server.public_ip

}
output "ip-jenkins-agent" {
  value = aws_instance.Jenkins-agent.public_ip

}
