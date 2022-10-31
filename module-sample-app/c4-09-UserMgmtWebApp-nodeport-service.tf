# Resource: Kubernetes Service Manifest (Type: NodePort)
resource "kubernetes_service_v1" "usermgmt_np_service" {
  depends_on = [var.sample_app_depends_on]  
  metadata {
    name = "usermgmt-webapp-nodeport-service"
    annotations = {
      "alb.ingress.kubernetes.io/healthcheck-path" = "/login"
    }    
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.usermgmt_webapp.spec.0.selector.0.match_labels.app
    }
    port {
      name        = "http"
      port        = 8080
      target_port = 8080
    }

    type = "NodePort"
  }
}