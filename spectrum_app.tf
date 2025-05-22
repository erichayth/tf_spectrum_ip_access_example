resource "cloudflare_spectrum_application" "terraform_managed_resource_89ef59f7b5d942e5b895ac868db2fef7" {
  ip_firewall    = true
  origin_port    = 514
  protocol       = "tcp/6514"
  proxy_protocol = "off"
  tls            = "flexible"
  traffic_type   = "direct"
  zone_id        = "5659396072a0d97d28cda7ed2632d7d3"
  dns {
    name = "syslog-ext.erichayth.com"
    type = "CNAME"
  }
  edge_ips {
    connectivity = "all"
    type         = "dynamic"
  }
  origin_dns {
    name = "syslog-lb.erichayth.com"
  }
}

