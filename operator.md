## Kubernetes Datadog Integration

This service manages the integration of Datadog for monitoring and logging within a Kubernetes cluster. Datadog provides comprehensive observability into your Kubernetes environments, tracking metrics, logs, and other performance indicators in real-time.

### Design Decisions 

- **Helm Chart Version**: The module deploys the Datadog agent using Helm. The version is pinned to 3.25.4 to ensure consistent behavior across deployments.
- **Namespace Management**: The Helm release creates a namespace for the Datadog agent to avoid conflicts with other resources.
- **Values Management**: Key values for the Helm chart are populated from Terraform variables and local settings to maintain flexibility and customization.
- **Authentication**: The Kubernetes cluster authentication information is retrieved dynamically from the input variables, simplifying the integration process.

### Runbook

#### Issue: Datadog Agent Not Collecting Logs

Sometimes the Datadog agent may not collect logs as expected. This could be due to configuration issues or agent deployment problems.

To verify the log collection settings:

```sh
kubectl get configmap datadog -o yaml | grep -A 5 logs_config
```

Expect to see:
```yaml
logs_config:
  container_collect_all: true
```

If `container_collect_all` is not set to `true`, update the `values.yaml` file and reapply the Helm chart.

#### Issue: Datadog Agent Failing to Start

If the Datadog agent pods are not starting, check their status:

```sh
kubectl get pods -n <namespace> | grep datadog
```

If the pods are in a `CrashLoopBackOff` or `Error` state, describe the pod for more details:

```sh
kubectl describe pod <pod_name> -n <namespace>
```

Look for any errors or events that indicate why the pod is failing to start.

#### Issue: Missing Metrics in Datadog Dashboard

If metrics from your Kubernetes cluster are not appearing in the Datadog dashboard, ensure that the cluster and Datadog API keys are correctly configured:

```sh
kubectl get secret datadog -o yaml -n <namespace> | grep api-key
```

This should show the API key that was configured during the Helm installation. If the key is missing or incorrect, update the secret and restart the Datadog agent.

#### Issue: High Memory/CPU Usage by Datadog Agent

Check the resource usage of the Datadog agent pods:

```sh
kubectl top pod -n <namespace> | grep datadog
```

If the usage is too high, consider adjusting the resource requests/limits in the `values.yaml` file:

```yaml
resources:
  requests:
    memory: "256Mi"
    cpu: "100m"
  limits:
    memory: "512Mi"
    cpu: "200m"
```

Apply the updated values by re-running the Helm deployment:

```sh
helm upgrade --install datadog-agent -f values.yaml datadog/datadog -n <namespace>
```

### Kubernetes Cluster Connectivity Issues

If the Datadog agent is unable to communicate with the Kubernetes API, ensure that the service account and the associated roles/role bindings have the necessary permissions.

Check the status of the service account:

```sh
kubectl get serviceaccount datadog-agent -n <namespace>
```

Verify the roles and role bindings:

```sh
kubectl get roles,rolebindings -n <namespace>
```

Ensure that the `datadog-agent` service account has the required permissions to access cluster resources. If not, adjust the roles/role bindings accordingly.

