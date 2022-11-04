# Data Platform Admission Controller

A helm chart for the DP Image Admission Controller, which whitelists container registries and images for use in the Data Platform.

## Installing the Chart

Initially use ArgoCD. More to follow.

## Configuration

| Parameter | Description | Default
| - | - | -
| `nameOverride` | Used to override name of chart | `""`
| `fullnameOverride` | Used to override the full name of the application | `""`
| `replicaCount` | Number of replicas | `1`
| `image.registry` | Registry of image to pull for deployment | `""`
| `image.repository` | Repository of image to pull for deployment | `security/admission/dp-image-admission-controller`
| `image.tag` | Tag of image to pull from repository | `Chart.AppVersion`
| `image.pullPolicy` | Policy of how to pull image | `IfNotPresent`
| `env.tls` | Use TLS for communication | `true`
| `env.logLevel` | Log level for Go binary | `trace`
| `env.logJson` | Log output as JSON | `false`
| `serviceAccount.create` | Whether to create a service account or not | `true`
| `serviceAccount.name` | The name of the service account to create or use | `""`
| `rbac.create` | Whether to create rbac resources or not | `true`
| `webhookService.port` | Incoming port used by webhook service | `443`
| `webhookService.targetPort` | Target port used by webhook service | `443`