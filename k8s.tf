data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${google_container_cluster.default.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.default.master_auth[0].cluster_ca_certificate)
}

resource "kubernetes_deployment_v1" "default" {
  metadata {
    name = "deployment-name"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "label-name"
      }
    }
    template {
      metadata {
        labels = {
          app = "label-name"
        }
      }
      spec {
        container {
          name  = "express-ts"
          image = var.dockerImage
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "default" {
  metadata {
    name = "service-name"
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.default.spec[0].selector[0].match_labels.app
    }
    port {
      port        = 80
      target_port = 3000
    }
    type = "LoadBalancer"
  }
  depends_on = [time_sleep.wait_service_cleanup]
}

resource "time_sleep" "wait_service_cleanup" {
  depends_on = [google_container_cluster.default]
  destroy_duration = "180s"
}