// Auto-generated variable declarations from massdriver.yaml
variable "clusterAgent" {
  type = object({
    metricsProvider = optional(object({
      enabled = optional(bool)
    }))
  })
}
variable "datadog" {
  type = object({
    apiKey = string
    apm = object({
      portEnabled = optional(bool)
    })
    dogstatsd = object({
      useHostPort = optional(bool)
    })
    env = list(object({
      name  = optional(string)
      value = optional(string)
    }))
    logs = object({
      enabled = optional(bool)
    })
    site = string
  })
}
variable "kubernetes_cluster" {
  type = object({
    data = object({
      authentication = object({
        cluster = object({
          certificate-authority-data = string
          server                     = string
        })
        user = object({
          token = string
        })
      })
      infrastructure = optional(object({
        arn             = optional(string)
        oidc_issuer_url = optional(string)
        ari             = optional(string)
        grn             = optional(string)
      }))
    })
    specs = optional(object({
      aws = optional(object({
        region = optional(string)
      }))
      azure = optional(object({
        region = string
      }))
      gcp = optional(object({
        project = optional(string)
        region  = optional(string)
      }))
      kubernetes = object({
        cloud            = string
        distribution     = string
        platform_version = optional(string)
        version          = string
      })
    }))
  })
}
variable "md_metadata" {
  type = object({
    default_tags = object({
      managed-by  = string
      md-manifest = string
      md-package  = string
      md-project  = string
      md-target   = string
    })
    deployment = object({
      id = string
    })
    name_prefix = string
    observability = object({
      alarm_webhook_url = string
    })
    package = object({
      created_at             = string
      deployment_enqueued_at = string
      previous_status        = string
      updated_at             = string
    })
    target = object({
      contact_email = string
    })
  })
}
variable "namespace" {
  type = string
}
variable "networkMonitoring" {
  type = object({
    enabled = optional(bool)
  })
}
variable "securityAgent" {
  type = object({
    runtime = optional(object({
      enabled = optional(bool)
    }))
  })
}
variable "systemProbe" {
  type = object({
    enableOOMKill        = optional(bool)
    enableTCPQueueLength = optional(bool)
  })
}
