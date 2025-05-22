resource "cloudflare_access_rule" "terraform_managed_resource_1a6a2a3eda684e609e3be4b6ccc1db7b" {
  mode    = "whitelist"
  zone_id = "5659396072a0d97d28cda7ed2632d7d3"
  configuration {
    target = "ip"
    value  = "1.1.1.1" # update with your IP
  }
}

