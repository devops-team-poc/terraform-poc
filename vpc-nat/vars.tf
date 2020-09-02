variable "AWS_ACCESS_KEY" {

}

variable "AWS_SECRET_KEY" {

}

variable "AWS_REGION" {
    default = "us-east-1"

}

variable "AMIS" {
    type = map(string)
    default = {
        us-east-2 = "ami-08f3d892de259504d"
        us-east-1 = "ami-0ac80df6eff0e70b5"
        eu-west-1 = "ami-098f16afa9edf40be"
    }
}

variable "PATH_PUBLIC_KEY" {
    default = "demo.pub"
}

variable "PATH_PRIVATE_KEY" {
    default = "demo"
}

variable "INSTANCE_USERNAME" {
    default = "ubuntu"
}

variable "INSTANCE_DEVICE_NAME" {
    default = "/dev/xvdh"   
}

variable "RDS_USERNAME" {
    default = "root"
}

variable "RDS_PASSWORD" {
 
}