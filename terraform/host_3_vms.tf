data "vsphere_resource_pool" "pool_3" {
  name          = "${var.vsphere_hosts["host_3"].ip}/Resources"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datastore" "vsphere_datastore_ssd_3" {
  name          = "${var.vsphere_hosts["host_3"].datastore_ssd}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datastore" "vsphere_datastore_hdd_3" {
  name          = "${var.vsphere_hosts["host_3"].datastore_hdd}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

resource "vsphere_virtual_machine" "host_3" {
    for_each = var.vsphere_hosts.host_3.vms
    name = each.value.host_name

    resource_pool_id = "${data.vsphere_resource_pool.pool_3.id}"
    datastore_id     = "${data.vsphere_datastore.vsphere_datastore_ssd_3.id}"

    guest_id = "${data.vsphere_virtual_machine.template.guest_id}"
    scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"
    
    sync_time_with_host = false
    memory_hot_add_enabled = true
    cpu_hot_add_enabled = true

    num_cpus =  each.value.host_name == var.vsphere_hosts.host_3.vms.worker_3.host_name ? 40 : 4
    memory   = each.value.host_name == var.vsphere_hosts.host_3.vms.worker_3.host_name ? 12288 : 4096

    network_interface {
        network_id   = "${data.vsphere_network.lan.id}"
        adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
    }

    disk {
        datastore_id     = "${data.vsphere_datastore.vsphere_datastore_ssd_3.id}"
        label            = "disk0"
        size             = 70
        eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
        thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
        unit_number      = 0
    }

    dynamic "disk" {
        for_each = { for k, v in var.vsphere_hosts.host_3.vms.ceph_3 : k => v if v == each.value.host_name }
        content {  
            datastore_id     = "${data.vsphere_datastore.vsphere_datastore_ssd_3.id}"
            label = "disk1"  
            size = 500
            unit_number = 1
        }
    }

    dynamic "disk" {
        for_each = { for k, v in var.vsphere_hosts.host_3.vms.ceph_3 : k => v if v == each.value.host_name }
        content {
            datastore_id     = "${data.vsphere_datastore.vsphere_datastore_hdd_3.id}"
            label = "disk2"  
            size = 600
            unit_number = 2
        }
    }

    clone {
        template_uuid = "${data.vsphere_virtual_machine.template.id}"

        customize {
            linux_options {
                host_name = each.value.host_name
                domain = ""
            }
            dns_server_list     = ["192.168.44.25", "192.168.55.35"]
            network_interface {
                ipv4_address = each.value.ip
                ipv4_netmask = "24"
            }
            ipv4_gateway = "${var.gateway}"
        }
    }
}

