locals {
  project_id       = var.project_id
  network          = "default"
  image            = "debian-cloud/debian-11"
  ssh_user         = "ansible"
  private_key_path = "/home/reconfigure/.ssh/id_rsa"
}

provider "google" {
  project = var.project_id
  region  = "us-central1"
  zone    = "us-central1-a"
}

resource "google_service_account" "ansible" {
  account_id = "ansible-admin"
}

resource "google_compute_firewall" "web" {
  name    = "web-access"
  network = local.network

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web"]
}

locals {
  instance_names = ["ansible-server", "ansible-client-one", "ansible-client-two"]
}

resource "google_compute_instance" "instances" {
  for_each = toset(local.instance_names)

  name         = each.key
  machine_type = "e2-medium"

  boot_disk {
    initialize_params {
      image = local.image
      labels = {
        my_label = "value"
      }
    }
  }

  # scratch_disk {
  #   interface = "SCSI"
  # }

  network_interface {
    network = local.network

    access_config {
    }
  }

  tags = ["web"]

  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.private_key_path)
      host        = self.network_interface[0].access_config[0].nat_ip
    }
  }

  provisioner "local-exec" {
    environment = {
      "LANG" = "en_US.UTF-8"
    }

    command = "ansible-playbook -i ${self.network_interface[0].access_config[0].nat_ip}, --private-key ${local.private_key_path} playbook.yaml"
  }
}
