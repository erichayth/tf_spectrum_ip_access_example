terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.52.0"
    }
  }
}

provider "cloudflare" {
  email = "<EMAIL>"
  api_key = "<API KEY>"
}
