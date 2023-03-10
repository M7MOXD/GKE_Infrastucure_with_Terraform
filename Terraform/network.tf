resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}
resource "google_project_service" "container" {
  service = "container.googleapis.com"
}
resource "google_compute_network" "my_vpc" {
  name                    = "my-vpc"
  auto_create_subnetworks = false
  depends_on = [
    google_project_service.compute,
    google_project_service.container
  ]
}
resource "google_compute_router" "my_router" {
  name    = "my-router"
  region  = google_compute_subnetwork.my_subnet["management"].region
  network = google_compute_network.my_vpc.id
  bgp {
    asn = 64514
  }
}
resource "google_compute_router_nat" "my_nat" {
  name                               = "my-router-nat"
  router                             = google_compute_router.my_router.name
  region                             = google_compute_router.my_router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
resource "google_compute_firewall" "ssh" {
  name    = "ssh"
  network = google_compute_network.my_vpc.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["35.235.240.0/20"]
}
resource "google_compute_firewall" "http" {
  name    = "http"
  network = google_compute_network.my_vpc.name
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = ["0.0.0.0/0"]
}