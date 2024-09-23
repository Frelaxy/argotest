// variables
vsphere_server          = "192.168.55.128"
vsphere_user            = "kirill.masliukov@idcollect.ru"
vsphere_password        = "Y9oJxVc1i0Hy$t"

// template
vsphere_virtual_machine = "vm-template-ubuntu-24.04-terraform" # vm-template-ubuntu-24.04-terraform

// guest ssh
guest_ssh_user        = "adminpower"
guest_ssh_password    = "QWerty321"

// ip_addressed
gateway = "192.168.55.200"

// data_sources
lan                     = "VM Network"
vsphere_datacenter      = "sel3"


vsphere_hosts = {
    host_1 = { 
        ip = "10.200.34.124", 
        datastore_ssd = "Dts_34.124_SSD_RAID10", 
        datastore_hdd = "Dts_34.124_HDD_RAID1", 
        vms = {
            master_1 = { ip = "192.168.55.64", host_name = "s-sel-idc-kuber-master-1"},
            worker_1 = { ip = "192.168.55.67", host_name = "s-sel-idc-kuber-worker-1"},
            ceph_1 = { ip = "192.168.55.70", host_name = "s-sel-idc-kuber-ceph-1",}
        }
    },
    host_2 = { 
        ip = "10.200.34.135", 
        datastore_ssd = "Dts-34.135-ssd", 
        datastore_hdd = "Dts-34.135-HDD", 
        vms = {
            master_2 = { ip = "192.168.55.65", host_name = "s-sel-idc-kuber-master-2"},
            worker_2 = { ip = "192.168.55.68", host_name = "s-sel-idc-kuber-worker-2"},
            ceph_2 = { ip = "192.168.55.71", host_name = "s-sel-idc-kuber-ceph-2"}
        } 
    }
    host_3 = { 
        ip = "10.200.34.130", 
        datastore_ssd = "DTS_SSD_55.130_7Tb", 
        datastore_hdd = "Dts_HDD_55.130",
        vms = {
            master_3 = { ip = "192.168.55.66", host_name = "s-sel-idc-kuber-master-3"},
            worker_3 = { ip = "192.168.55.69", host_name = "s-sel-idc-kuber-worker-3"},
            ceph_3 = { ip = "192.168.55.72", host_name = "s-sel-idc-kuber-ceph-3"}
        } 
    }
}