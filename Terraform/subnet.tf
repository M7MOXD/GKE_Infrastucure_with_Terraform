resource "google_compute_subnetwork" "my_subnet" {
  for_each                 = var.my_subnet
  name                     = each.value["name"]
  network                  = google_compute_network.my_vpc.id
  ip_cidr_range            = each.value["cidr"]
  private_ip_google_access = true
  region                   = "us-central1"
}