variable "vpc_cidr"{
    default =  "192.48.0.0/16"

}
variable "region" {
  default = "us-east-1"
}


data "aws_availability_zones""azs"{}


variable "pub-subnet-cidr" {
  description = "Available cidr blocks for subnets."
  type        = list(string)
  default     = [
    "192.48.0.0/18",
    "192.48.64.0/18",
    
  ]
}

variable "pri-subnet-cidr" {
  description = "Available cidr blocks for subnets."
  type        = list(string)
  default     = [
  
    "192.48.128.0/18",
    "192.48.192.0/18",
  ]
}

