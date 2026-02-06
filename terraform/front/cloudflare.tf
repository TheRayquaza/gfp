resource "cloudflare_dns_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.gfp_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = var.cloudflare_zone_id
  name    = replace(each.value.name, "/\\.$/", "")
  content   = each.value.record
  type    = each.value.type
  proxied = true
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cert_verify" {
  certificate_arn         = aws_acm_certificate.gfp_cert.arn
  validation_record_fqdns = [for record in cloudflare_dns_record.validation : record.name]
}

resource "aws_acm_certificate" "gfp_cert" {
  domain_name       = "gfp.rayq.app"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_dns_record" "cloudfront_cname" {
  zone_id = var.cloudflare_zone_id
  name    = "gfp" 
  content = aws_cloudfront_distribution.s3_distribution.domain_name
  type    = "CNAME"
  proxied = false 
  ttl     = 360
}
