data "terraform_remote_state" "network_details" {
  backend = "gcs"

  config = {
    bucket = "provide your bucket name"           # GCS bucket name
    prefix = "student.01-network-state"  # Path to the remote state file
  }
}

resource "google_compute_instance" "my_vm" {
  name         = "amit-instance"
  machine_type = "e2-micro"
  zone         = "us-east1-b"

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

 /* metadata = {
    Name = "amit-instance"
    "ssh-keys" = "ubuntu:${file("/home/amit/gcp/terraform_base/networking/keys/vmkey.pub")}"  
  }
*/
  tags = ["amit-instance"]
}

