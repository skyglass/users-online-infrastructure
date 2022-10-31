# Resource: Kubernetes Storage Class
resource "kubernetes_storage_class_v1" "ebs_sc" {  
  depends_on = [var.sample_app_depends_on]
  metadata {
    name = "ebs-sc"
  }
  storage_provisioner = "ebs.csi.aws.com"
  volume_binding_mode = "WaitForFirstConsumer"
}