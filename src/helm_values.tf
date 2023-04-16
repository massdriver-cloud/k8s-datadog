locals {
  cluster_name = try(
    element(split("/", var.kubernetes_cluster.data.infrastructure.arn), length(split("/", var.kubernetes_cluster.data.infrastructure.arn))-1),
    element(split("/", var.kubernetes_cluster.data.infrastructure.ari), length(split("/", var.kubernetes_cluster.data.infrastructure.ari))-1),
    element(split("/", var.kubernetes_cluster.data.infrastructure.grn), length(split("/", var.kubernetes_cluster.data.infrastructure.grn))-1)
  )

  helm_values = {
    commonLabels = var.md_metadata.default_tags
    datadog = {
      clusterName = local.cluster_name
      logs = {
        containerCollectAll = lookup(var.datadog.logs, "enabled", false)
      }
    }
  }
}