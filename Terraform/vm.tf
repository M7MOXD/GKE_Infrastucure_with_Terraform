resource "google_compute_instance" "my_instance" {
  name         = "my-instance"
  machine_type = "e2-medium"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network    = google_compute_network.my_vpc.name
    subnetwork = google_compute_subnetwork.my_subnet["management"].name
  }
  service_account {
    email  = google_service_account.custom_compute_sa.email
    scopes = ["cloud-platform"]
  }
}