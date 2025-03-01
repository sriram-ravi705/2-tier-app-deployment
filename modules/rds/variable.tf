variable "db_sub_name" {}
variable "sg" {}
variable "db_username" {
    sensitive = true
}
variable "password" {
    sensitive = true
}
variable "private_subnets" {}
variable "db_name" {}
