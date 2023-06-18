provider "google" {
  project = "yolo-client"
  region  = "us-central1"
  zone    = "us-central1-a"
}

 resource "google_compute_instance" "default" {
  count      = length(var.instances)
  name      = var.instances[count.index]
  machine_type = "e2-medium"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_lable = "value"
      }
    }
  }
 
#   scratch_disk {
#     interface = "SCSI"
#   }
  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {
    }
  }
  metadata_startup_script = "sudo apt-add-repository ppa:ansible/ansible; sudo apt update; sudo apt pip install ansible"
}