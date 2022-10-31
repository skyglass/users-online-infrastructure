# Resource: ACM Certificate
resource "aws_acm_certificate" "acm_cert" {
  depends_on = [var.sample_app_depends_on]
  domain_name       = "*.greeta.net"
  validation_method = "DNS"

  tags = {
    Environment = "dev"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Outputs
output "acm_certificate_id" {
  value = aws_acm_certificate.acm_cert.id 
}

output "acm_certificate_arn" {
  value = aws_acm_certificate.acm_cert.arn
}

output "acm_certificate_status" {
  value = aws_acm_certificate.acm_cert.status
}
