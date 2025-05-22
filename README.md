# Cloudflare Spectrum with IP Access Rules - Terraform Example

This repository demonstrates how to configure Cloudflare Spectrum applications with associated IP Access Rules using Terraform. The example creates a syslog application that accepts TCP traffic on port 6514 and restricts access to specific IP addresses.

## Repository Overview

This Terraform configuration showcases:
- **Cloudflare Spectrum Application**: A TCP proxy for syslog traffic
- **IP Access Rules**: Whitelist-based access control for the application
- **Provider Configuration**: Cloudflare Terraform provider setup

## What is Cloudflare Spectrum?

Cloudflare Spectrum extends Cloudflare's security and performance benefits to any TCP or UDP application. Unlike traditional web applications that use HTTP/HTTPS, Spectrum allows you to proxy any protocol through Cloudflare's global network.

### Key Benefits:
- **DDoS Protection**: Protects non-web applications from volumetric attacks
- **Global Anycast**: Routes traffic through Cloudflare's nearest data center
- **IP Firewall Integration**: Works seamlessly with Cloudflare's security features
- **Load Balancing**: Distributes traffic across multiple origin servers
- **Analytics**: Provides insights into traffic patterns and security events

### Common Use Cases:
- Gaming servers
- IoT device communication
- Database connections
- Syslog collection (as demonstrated in this example)
- SSH/RDP access
- Email servers (SMTP, IMAP, POP3)

## What are IP Access Rules?

Cloudflare IP Access Rules provide granular control over which IP addresses, IP ranges, countries, or ASNs can access your applications. They act as a firewall at the edge, blocking or allowing traffic before it reaches your origin server.

### Rule Modes:
- **Whitelist**: Only allow specified IPs/ranges (used in this example)
- **Block**: Deny access from specified IPs/ranges
- **Challenge**: Present a CAPTCHA challenge
- **JavaScript Challenge**: Require JavaScript execution
- **Managed Challenge**: Use Cloudflare's managed challenge system

### Target Types:
- **IP Address**: Single IPv4 or IPv6 address
- **IP Range**: CIDR notation for multiple addresses
- **Country**: Two-letter country codes
- **ASN**: Autonomous System Numbers

## Configuration Details

### Spectrum Application (`spectrum_app.tf`)
```hcl
resource "cloudflare_spectrum_application" "terraform_managed_resource_89ef59f7b5d942e5b895ac868db2fef7" {
  ip_firewall    = true          # Enable IP firewall integration
  origin_port    = 514           # Origin server port (standard syslog)
  protocol       = "tcp/6514"    # External protocol and port
  proxy_protocol = "off"         # Proxy protocol disabled
  tls            = "flexible"    # TLS termination at edge
  traffic_type   = "direct"      # Direct traffic routing
  zone_id        = "..."         # Cloudflare zone identifier
  
  dns {
    name = "syslog-ext.erichayth.com"  # External DNS name
    type = "CNAME"                     # DNS record type
  }
  
  edge_ips {
    connectivity = "all"    # IPv4 and IPv6 support
    type         = "dynamic" # Dynamic IP assignment
  }
  
  origin_dns {
    name = "syslog-lb.erichayth.com"   # Origin server DNS name
  }
}
```

### IP Access Rule (`ip_access.tf`)
```hcl
resource "cloudflare_access_rule" "terraform_managed_resource_1a6a2a3eda684e609e3be4b6ccc1db7b" {
  mode    = "whitelist"           # Only allow specified IPs
  zone_id = "..."                 # Cloudflare zone identifier
  
  configuration {
    target = "ip"                 # Target type: IP address
    value  = "1.1.1.1"        # Allowed IP address
  }
}
```

## Prerequisites

1. **Cloudflare Account**: Active Cloudflare account with the target domain
2. **Spectrum Subscription**: Spectrum is available on Pro, Business, and Enterprise plans
3. **Terraform**: Version compatible with the Cloudflare provider
4. **API Credentials**: Cloudflare email and API key

## Usage

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd spectrum
   ```

2. **Configure credentials**:
   Update `provider.tf` with your Cloudflare email and API key:
   ```hcl
   provider "cloudflare" {
     email   = "your-email@example.com"
     api_key = "your-api-key"
   }
   ```

3. **Update configuration**:
   - Modify `zone_id` values to match your Cloudflare zone
   - Update DNS names to match your domain
   - Adjust IP addresses in the access rule
   - Configure origin server details as needed

4. **Deploy**:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## Security Considerations

- **API Key Protection**: Store credentials securely, consider using environment variables
- **IP Whitelist Maintenance**: Regularly review and update allowed IP addresses
- **Origin Security**: Ensure origin servers are properly secured since Spectrum bypasses some Cloudflare security features
- **TLS Configuration**: Choose appropriate TLS settings based on your security requirements

## Monitoring and Troubleshooting

- Use Cloudflare Analytics to monitor Spectrum application performance
- Check Security Events for blocked connection attempts
- Verify DNS resolution for both external and origin DNS names
- Test connectivity from whitelisted IP addresses

## Additional Resources

- [Cloudflare Spectrum Documentation](https://developers.cloudflare.com/spectrum/)
- [IP Access Rules Documentation](https://developers.cloudflare.com/waf/tools/ip-access-rules/)
- [Terraform Cloudflare Provider](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs)
