resource "aws_key_pair" "macbook_key" {
    key_name   = "my_aws_key"
    public_key = file("~/.ssh/my_aws_key.pub")
}

resource "aws_instance" "controlplane_node" {
    ami                         = "ami-09ac0b140f63d3458"
    instance_type               = "t3.micro"
    key_name                    = aws_key_pair.macbook_key.key_name
    subnet_id                   = aws_subnet.k8s_subnet.id
    vpc_security_group_ids      = [aws_security_group.k8s_sg.id]
    associate_public_ip_address = true 
    tags = {
        Name = "k8s_controlplane_node"
    }
}

resource "aws_instance" "worker_node" {
    ami                         = "ami-09ac0b140f63d3458"
    instance_type               = "t3.micro"
    key_name                    = aws_key_pair.macbook_key.key_name
    subnet_id                   = aws_subnet.k8s_subnet.id
    vpc_security_group_ids      = [aws_security_group.k8s_sg.id]
    associate_public_ip_address = true 
    tags = {
        Name = "k8s_worker_node"
    }
}