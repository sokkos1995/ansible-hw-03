output "ssh_commands" {
  description = "SSH commands to connect to VMs"
  value = {
    for name, instance in yandex_compute_instance.vm :
    name => "ssh -i ${var.ssh_private_key_path} ${var.ssh_user}@${instance.network_interface[0].nat_ip_address}"
  }
}

output "external_ips" {
  description = "External IP addresses of VMs"
  value = {
    for name, instance in yandex_compute_instance.vm :
    name => instance.network_interface[0].nat_ip_address
  }
}
