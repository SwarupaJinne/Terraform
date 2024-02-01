variable "cidr_block" {
  type = list
  default = ["10.0.0.0/16", "10.0.2.0/24"]
}

variable "instance_tenancy" {
  type = string
  default = "default"
}

variable "dns_support" {
  type = bool
  default = true
}

variable "dns_hostnames" {
  type = bool
  default = true
}

variable "tags" {
  type = map(string)
  default = {
    Name = "timing-1"
    Terraform = "true"
    Environment = "DEV"
  }
}

variable "postgress_port" {
  type = number
  default = 5432
}

variable "instance_names" {
  type = list
  default = ["web-server","api-server","db-server"]
}

variable "isProd" {
    type = bool
    default = true 

  
}



