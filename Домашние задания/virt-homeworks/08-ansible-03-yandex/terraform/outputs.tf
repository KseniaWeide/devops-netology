output "clickhouse" {
  value = "${yandex_compute_instance.clickhouse.network_interface.0.nat_ip_address}"
}
output "vector" {
  value = "${yandex_compute_instance.vector.network_interface.0.nat_ip_address}"
}
output "lighthouse" {
  value = "${yandex_compute_instance.lighthouse.network_interface.0.nat_ip_address}"
}
