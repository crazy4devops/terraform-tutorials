terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "2.2.2"
    }
    random = {
      source = "hashicorp/random"
      version = "3.1.2"
    }

  }
}


docker network create \
  --driver=bridge \
  --subnet=182.18.0.1/24 \
  --gateway=182.18.0.1 \
  wp-mysql-network

  Name: wp-mysql-network
Driver: bridge
subnet: 182.18.0.1/24
Gateway: 182.18.0.1