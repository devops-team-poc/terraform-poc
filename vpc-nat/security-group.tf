resource "aws_security_group" "allow-ssh-jenkins" {
    vpc_id = aws_vpc.main.id
    name = "allow-ssh-jenkins"
    description = "security group that allow ssh, Jenkins and all egress traffic"

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "allow-ssh-jenkins"
    }
}

resource "aws_security_group" "allow-mariadb" {
    vpc_id = aws_vpc.main.id
    name = "allow-mariadb"
    description = "Allow mariaDB port"

    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = [aws_security_group.allow-ssh-jenkins.id]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        self = true
    }

    tags =  {
        Name = "allow-mariadb"
    }
}