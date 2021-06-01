variable "jenkins_build_id" {

}
variable "env" {

}
variable "name" {

}
variable "instance_type" {

}
variable "region" {

}


locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
  ami_name  = "test"
}
