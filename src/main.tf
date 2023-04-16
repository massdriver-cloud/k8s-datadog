locals {
  chart_version = "3.25.4"
  release       = var.md_metadata.name_prefix
}

resource "helm_release" "main" {
  name             = local.release
  chart            = "datadog"
  repository       = "https://helm.datadoghq.com"
  version          = local.chart_version
  namespace        = var.namespace
  create_namespace = true

  values = [
    "${file("${path.module}/values.yaml")}",
    yamlencode(local.helm_values),
    yamlencode("${try(jsondecode(file("${path.module}/_params.auto.tfvars.json")), {})}"),
  ]
}