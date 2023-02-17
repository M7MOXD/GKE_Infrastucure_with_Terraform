resource "google_service_account" "custom_compute_sa" {
  account_id   = "custom-compute-sa"
  display_name = "Custom Compute Service Account"
}
resource "google_service_account" "custom_gke_sa" {
  account_id   = "custom-gke-sa"
  display_name = "Custom GKE Service Account"
}
resource "google_project_iam_member" "compute_sa" {
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.custom_compute_sa.email}"
  project = google_service_account.custom_compute_sa.project
}
resource "google_project_iam_member" "gke_sa" {
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.custom_gke_sa.email}"
  project = google_service_account.custom_gke_sa.project
}