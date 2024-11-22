data "terraform_remote_state" "network_details" {
  backend = "gcs"

  config = {
    bucket = "terraformgcpow23"           # GCS bucket name
    prefix = "student.01-network-state"  # Path to the remote state file
  }
}

resource "google_compute_instance" "my_vm" {
  name         = "amit-instance"
  machine_type = "e2-micro"
  zone         = "asia-south1-a"

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/4751156868206452390"
    }
  }

  network_interface {
    network    = data.terraform_remote_state.network_details.outputs.network_name
    subnetwork = data.terraform_remote_state.network_details.outputs.subnetwork_name
    access_config {}
  }

  metadata = {
    Name = "amit-instance"
  }

  tags = ["amit-instance"]
}
