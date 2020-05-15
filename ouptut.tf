output "hostname" {
  description = "Hostname"
  value       = vsphere_virtual_machine.vm.*.name
}
