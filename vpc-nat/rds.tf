resource "aws_db_subnet_group" "mariadb-subnet" {
    name = "mariadb-subnet"
    description = "RDS subnet group"
    subnet_ids = [aws_subnet.main-private-1.id, aws_subnet.main-private-2.id]
}

resource "aws_db_parameter_group" "mariadb-parameters" {
    name = "mariadb-parameters"
    family = "mariadb10.1"
    description = "MariabDB parameter group"

    parameter {
        name = "max_allowed_packet"
        value = "16777216"
    }
}

resource "aws_db_instance" "mariadb" {
    allocated_storage = 100
    storage_type = "gp2"
    engine = "mariadb"
    engine_version = "10.1.14"
    instance_class = "db.t2.micro" # Only for the free tier
    name = "mariadb"
    username = var.RDS_USERNAME 
    password = var.RDS_PASSWORD
    db_subnet_group_name = aws_db_subnet_group.mariadb-subnet.name
    parameter_group_name = aws_db_parameter_group.mariadb-parameters.name
    multi_az = "false" # set is true to have HIGH AVALABILITY : 2 instance synchronized with each other
    vpc_security_group_ids = [aws_security_group.allow-mariadb.id]
    backup_retention_period = 30 #Time period to keep backup
    availability_zone = aws_subnet.main-private-1.availability_zone #preffered AZ
    skip_final_snapshot = true # Skip final snapshot while doing "terraform destory"

    tags = {
        Name = "mariadb-instance"
    }

}

