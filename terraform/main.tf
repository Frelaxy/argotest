provider "vsphere" {
    user = "${var.vsphere_user}"
    password = "${var.vsphere_password}"
    vsphere_server = "${var.vsphere_server}"
    
    allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name          = "${var.vsphere_datacenter}"
}

data "vsphere_network" "lan"{
  name          = "${var.lan}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "${var.vsphere_virtual_machine}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

