variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}
variable "vm_name" {}
variable "cpu" {}
variable "mem" {}
variable "disk_size" {
  default = "20"
}
variable "os" {
  default = "ubuntu64Guest"
}
