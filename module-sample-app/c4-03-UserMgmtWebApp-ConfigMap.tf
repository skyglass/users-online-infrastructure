 # Resource: Config Map
 resource "kubernetes_config_map_v1" "config_map" {
   depends_on = [var.sample_app_depends_on] 
   metadata {
     name = "usermanagement-dbcreation-script"
   }
   data = {
    "webappdb.sql" = "${file("${path.module}/webappdb.sql")}"
   }
 } 