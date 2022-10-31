# Kubernetes Service Manifest (Type: Load Balancer)
resource "kubernetes_ingress_v1" "ingress" {
  depends_on = [aws_acm_certificate.acm_cert]
  metadata {
    name = "ingress-externaldns-demo"
    annotations = {
      # Load Balancer Name
      "alb.ingress.kubernetes.io/load-balancer-name" = "ingress-externaldns-demo"
      # Ingress Core Settings
      "alb.ingress.kubernetes.io/scheme" = "internet-facing"
      # Health Check Settings
      "alb.ingress.kubernetes.io/healthcheck-protocol" =  "HTTP"
      "alb.ingress.kubernetes.io/healthcheck-port" = "traffic-port"
      #Important Note:  Need to add health check path annotations in service level if we are planning to use multiple targets in a load balancer    
      "alb.ingress.kubernetes.io/healthcheck-interval-seconds" = 15
      "alb.ingress.kubernetes.io/healthcheck-timeout-seconds" = 5
      "alb.ingress.kubernetes.io/success-codes" = 200
      "alb.ingress.kubernetes.io/healthy-threshold-count" = 2
      "alb.ingress.kubernetes.io/unhealthy-threshold-count" = 2
      ## SSL Settings
      # Option-1: Using Terraform jsonencode Function
      "alb.ingress.kubernetes.io/listen-ports" = jsonencode([{"HTTPS" = 443}, {"HTTP" = 80}])
      # "alb.ingress.kubernetes.io/actions.ssl-redirect" = jsonencode({"Type" = "redirect", "RedirectConfig" = { "Protocol" = "HTTPS", "Port" = "443", "StatusCode" = "HTTP_301"}})
      # Option-2: Using Terraform File Function      
      #"alb.ingress.kubernetes.io/listen-ports" = file("${path.module}/listen-ports/listen-ports.json")
      "alb.ingress.kubernetes.io/certificate-arn" =  "${aws_acm_certificate.acm_cert.arn}"
      #"alb.ingress.kubernetes.io/ssl-policy" = "ELBSecurityPolicy-TLS-1-1-2017-01" #Optional (Picks default if not used)    
      # SSL Redirect Setting
      "alb.ingress.kubernetes.io/ssl-redirect" = 443
      # External DNS - For creating a Record Set in Route53
      "external-dns.alpha.kubernetes.io/hostname" = "sonia.greeta.net"
      "ingress.kubernetes.io/rewrite-target" = "/"
    }    
  }
  spec {
    ingress_class_name = "my-aws-ingress-class" # Ingress Class 
    default_backend {
      service {
        name = kubernetes_service_v1.usermgmt_np_service.metadata[0].name
        port {
          number = 8080
        }
      }
    }               

    rule {
      http {
        path {
          backend {
            service {
              name = kubernetes_service_v1.myapp1_np_service.metadata[0].name
              port {
                number = 80
              }
            }
          }
          path = "/app1"
          path_type = "Prefix"
        }

        path {
          backend {
            service {
              name = kubernetes_service_v1.myapp2_np_service.metadata[0].name
              port {
                number = 80
              }
            }
          }
          path = "/app2"
          path_type = "Prefix"
        }       

        path {
          backend {
            service {
              name = kubernetes_service_v1.usermgmt_np_service.metadata[0].name
              port {
                number = 8080
              }
            }
          }
          path = "/"
          path_type = "Prefix"
        }

      }
    }
  }
}




