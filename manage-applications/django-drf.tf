// Django 

# Deployment 

resource "kubernetes_deployment" "DjangoDRF" {
  metadata {
    name = "django-drf"
    labels = {
      App = "DjangoDRF"
    }
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "DjangoDRF"
      }
    }
    template {
      metadata {
        labels = {
          App = "DjangoDRF"
        }
      }
      spec {
        container {
          image = "rafikli/django:latest"
          name  = "django-drf"

          port {
            container_port = 8000
          }
          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
# Autoscaler
resource "kubernetes_horizontal_pod_autoscaler" "django_hpa" {
  metadata {
    name = "djangohpa"
  }
  spec {
    min_replicas = 2
    max_replicas = 10
    scale_target_ref {
      kind = "Deployment"
      name = "django-drf"
    }
    metric {
      type = "Resource"
      resource {
        name = "cpu"
        target {
          type = "Utilization"
          average_utilization = "60"
        }
      }
    }
  }
}

# Django Service
resource "kubernetes_service" "DjangoDRF" {
  metadata {
    name = "django-drf"
  }
  spec {
    selector = {
      App = kubernetes_deployment.DjangoDRF.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 8000
      target_port = 8000
    }
    type = "LoadBalancer"
  }
}

output "django_ip" {
  value = kubernetes_service.DjangoDRF.status.0.load_balancer.0.ingress.0.hostname
}
