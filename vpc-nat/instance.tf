resource "aws_key_pair" "demo" {
    key_name = "demo"
    public_key = file(var.PATH_PUBLIC_KEY)
}

resource "aws_instance" "bastion" {
    ami = var.AMIS[var.AWS_REGION]
    instance_type = "t2.micro"
    tags = {
        Name = "Bastion-Server"
    }
    #Subnet
    subnet_id = aws_subnet.main-public-1.id

    # security Group

    vpc_security_group_ids = [aws_security_group.allow-ssh-jenkins.id]

    #Public Key
    key_name = aws_key_pair.demo.key_name
    #Passing userdata
    user_data = "${file("ebs-permanent-mount.sh")}"
}

resource "aws_ebs_volume" "ebs-volume-1" {
    availability_zone = "us-east-1a"
    size = "10"
    type  = "gp2"
    tags = {
        Name = "Extra Volume"
    }
}


resource "aws_volume_attachment" "ebs-volume-1-aws_volume_attachment" {
    device_name = var.INSTANCE_DEVICE_NAME
    volume_id = aws_ebs_volume.ebs-volume-1.id
    instance_id = aws_instance.bastion.id
    skip_destroy = true
}

output "ip" {
    value = aws_instance.bastion.public_ip
}

output "rds" {
    value = aws_db_instance.mariadb.endpoint
}