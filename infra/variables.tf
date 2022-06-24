
variable "region" {
  type        = string
  default     = "eu-west-2"
  description = "default region"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "default vpc_cidr_block"
}

variable "pub_sub1_cidr_block"{
   type        = string
   default     = "10.0.1.0/24"
}

variable "pub_sub2_cidr_block"{
   type        = string
   default     = "10.0.2.0/24"
}

variable "prv_sub1_cidr_block"{
   type        = string
   default     = "10.0.3.0/24"
}

variable "prv_sub2_cidr_block"{
   type        = string
   default     = "10.0.4.0/24"
}

variable "account_id"{
   type        = string
   default     = "xxxxxxxxx"
}

variable "db_username"{
   type        = string
   default     = "postgres"
}

variable "db_password"{
   type        = string
   default     = "mysecretpassword"
}

