variable "vsphere_user" {
    description = "The vSphere user with permission"
}

variable "vsphere_password" {
  description = "The vSphere password for vsphere_user"
}

variable "vsphere_server" {
  description = "The domain or ip address of vSphere server"
}

variable "vsphere_datacenter" {
  type        = string
}


variable "lan" {
  type        = string
}

variable "vsphere_virtual_machine" {
  type        = string
}

variable "count_instance" {
  default     = 0
}

variable "gateway" {
  type        = string
}

variable "vsphere_hosts" {
  # type        = string
}

variable "guest_ssh_user" {
  description = "SSH username to connect to the guest VM."
}

variable "guest_ssh_password" {
  description = "SSH password to connect to the guest VM."
}