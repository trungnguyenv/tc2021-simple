resource "aws_key_pair" "deployer" {
  public_key = file("~/.ssh/id_rsa.pub")
  key_name   = "${var.environment}-deployer"
}
