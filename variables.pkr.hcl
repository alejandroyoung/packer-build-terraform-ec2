variable "jenkins_build_id" {

}
variable "env" {

}
variable "name" {

}



locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
  ami_name  = "test"
}
