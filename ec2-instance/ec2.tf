resource "aws_instance" "instance-1" {
  ami           = "ami-03f4878755434977f"
  instance_type = "t3.micro"
}