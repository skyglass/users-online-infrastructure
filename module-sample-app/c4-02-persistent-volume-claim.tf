# Resource: Persistent Volume Claim
resource "kubernetes_persistent_volume_claim_v1" "pvc" {
  depends_on = [var.sample_app_depends_on]  
  metadata {
    name = "ebs-mysql-pv-claim"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    storage_class_name = kubernetes_storage_class_v1.ebs_sc.metadata.0.name 
    resources {
      requests = {
        storage = "4Gi"
      }
    }
  }
}

resource "aws_volume_attachment" "mysql_data" {
  depends_on = ["null_resource.stop_mysql_service2"]
  device_name = "/dev/xvdf"
  volume_id = "${aws_ebs_volume.create_volume.0.id}"
  instance_id = "i-0d48be4266da"
  skip_destroy = true
  force_detach = true
}

