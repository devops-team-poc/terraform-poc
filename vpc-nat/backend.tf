terraform {
  backend "s3" {
      bucket = "terraform-f234"
      key = "demo"
  }
}
