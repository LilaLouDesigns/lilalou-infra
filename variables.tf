variable "subnet-public" {
  type = map
  default = {
      sub-a = {
         az = "ap-southeast-4a"
         cidr = "10.0.0.0/20"
      }
      sub-b = {
         az = "ap-southeast-4b"
         cidr = "10.0.16.0/20"
      }
      sub-c = {
         az = "ap-southeast-4c"
         cidr = "10.0.32.0/20"
      }
   }
}

variable "basename" {
   description = "Prefix used for all resource names"
   default = "lou"
}

variable "profile" {
   description = "AWS CLI profile name"
}