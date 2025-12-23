# Webrix Helm Chart

This is a unified Helm chart that orchestrates the deployment of the Webrix stack on Kubernetes. It manages the following services:

*   **App**: The main application interface.
*   **Connect**: The connection service.
*   **Run**: The runtime execution service.
*   **DbService**: The database service layer.
*   **PostgreSQL**: Optional in-cluster database (powered by Bitnami).

This chart provides a flexible configuration to deploy either a full stack with an internal database or connect to an external PostgreSQL instance.

## Installation

To install the chart with the release name `my-webrix`:

```bash
helm install my-webrix .
```

To install with a custom values file:

```bash
helm install my-webrix . -f values-custom.yaml
```

## Configuration

The following table lists the configurable parameters of the Webrix chart and their default values.

| Key | Description | Default |
|-----|-------------|---------|
| `global.db_provider` | Database provider ('postgresql' or 'external') | `"postgresql"` |
| `global.external_db_url` | Full URL for external database connection | `""` |
| `global.domain.host` | Base domain for all services | `"blahblah.com"` |
| `global.ON_PREM` | Configuration for ON_PREM | `True` |
| `global.ORG` | Configuration for ORG | `"on-prem-org"` |
| `global.labels` | Configuration for labels | `{}` |
| `global.annotations` | Configuration for annotations | `{}` |
| `global.sharedEnv` | Environment variables shared across all deployments | `{}` |
| `deployments.app.enabled` | Enable app deployment | `True` |
| `deployments.app.replicas` | Number of pod replicas | `1` |
| `deployments.app.image.repository` | Container image repository | `"quay.io/webrix/mcp-s-app"` |
| `deployments.app.image.tag` | Container image tag | `"latest"` |
| `deployments.app.service.port` | Service port | `80` |
| `deployments.app.service.targetPort` | Container target port | `3000` |
| `deployments.app.resources.requests.cpu` | CPU resource request | `"100m"` |
| `deployments.app.resources.requests.memory` | Memory resource request | `"200Mi"` |
| `deployments.app.resources.limits.cpu` | CPU resource limit | `"1000m"` |
| `deployments.app.resources.limits.memory` | Memory resource limit | `"2048Mi"` |
| `deployments.app.nodeSelector` | Configuration for nodeSelector | `{}` |
| `deployments.app.tolerations` | Configuration for tolerations | `[]` |
| `deployments.app.affinity` | Configuration for affinity | `{}` |
| `deployments.app.podAnnotations` | Configuration for podAnnotations | `{}` |
| `deployments.app.podLabels` | Configuration for podLabels | `{}` |
| `deployments.app.serviceAccount.create` | Configuration for create | `True` |
| `deployments.app.serviceAccount.annotations` | Configuration for annotations | `{}` |
| `deployments.app.serviceAccount.name` | Configuration for name | `""` |
| `deployments.app.env.PORT` | Environment variable: PORT | `"3000"` |
| `deployments.app.env.DB_AUTH_SECRET` | Environment variable: DB_AUTH_SECRET | `"ZI39UlR2sN6HFZauuze0iNEZnNkF1wiOuGklm3bC8dk="` |
| `deployments.app.env.AUTH_SECRET` | Environment variable: AUTH_SECRET | `"aUi2V5iCVqUrbrdjKty1zH4HCqszXArV9BLVU2giqhY="` |
| `deployments.app.readinessProbe` | Configuration for readinessProbe | `{}` |
| `deployments.app.livenessProbe` | Configuration for livenessProbe | `{}` |
| `deployments.app.ingress.enabled` | Enable Ingress resource | `True` |
| `deployments.app.ingress.className` | Ingress class name | `"nginx"` |
| `deployments.app.ingress.annotations.nginx.ingress.kubernetes.io/rewrite-target` | Configuration for io/rewrite-target | `"/"` |
| `deployments.app.ingress.subdomain` | Subdomain for the service | `"webrix-app"` |
| `deployments.app.ingress.path` | Configuration for path | `"/"` |
| `deployments.app.ingress.pathType` | Configuration for pathType | `"Prefix"` |
| `deployments.app.ingress.tls` | Configuration for tls | `[]` |
| `deployments.connect.enabled` | Enable connect deployment | `True` |
| `deployments.connect.replicas` | Number of pod replicas | `1` |
| `deployments.connect.image.repository` | Container image repository | `"quay.io/webrix/mcp-s-connect"` |
| `deployments.connect.image.tag` | Container image tag | `"latest"` |
| `deployments.connect.service.port` | Service port | `80` |
| `deployments.connect.service.targetPort` | Container target port | `3000` |
| `deployments.connect.resources.requests.cpu` | CPU resource request | `"100m"` |
| `deployments.connect.resources.requests.memory` | Memory resource request | `"200Mi"` |
| `deployments.connect.resources.limits.cpu` | CPU resource limit | `"1000m"` |
| `deployments.connect.resources.limits.memory` | Memory resource limit | `"2048Mi"` |
| `deployments.connect.nodeSelector` | Configuration for nodeSelector | `{}` |
| `deployments.connect.tolerations` | Configuration for tolerations | `[]` |
| `deployments.connect.affinity` | Configuration for affinity | `{}` |
| `deployments.connect.podAnnotations` | Configuration for podAnnotations | `{}` |
| `deployments.connect.podLabels` | Configuration for podLabels | `{}` |
| `deployments.connect.serviceAccount.create` | Configuration for create | `True` |
| `deployments.connect.serviceAccount.annotations` | Configuration for annotations | `{}` |
| `deployments.connect.serviceAccount.name` | Configuration for name | `""` |
| `deployments.connect.env.PORT` | Environment variable: PORT | `"3000"` |
| `deployments.connect.env.DEBUG` | Environment variable: DEBUG | `"true"` |
| `deployments.connect.env.AUTH_TRUST_HOST` | Environment variable: AUTH_TRUST_HOST | `"true"` |
| `deployments.connect.env.DB_AUTH_SECRET` | Environment variable: DB_AUTH_SECRET | `"ZI39UlR2sN6HFZauuze0iNEZnNkF1wiOuGklm3bC8dk="` |
| `deployments.connect.env.AUTH_SECRET` | Environment variable: AUTH_SECRET | `"ZI39UlR2sN6HFZauuze0iNEZnNkF1wiOuGklm3bC8dk="` |
| `deployments.connect.readinessProbe` | Configuration for readinessProbe | `{}` |
| `deployments.connect.livenessProbe` | Configuration for livenessProbe | `{}` |
| `deployments.connect.ingress.enabled` | Enable Ingress resource | `True` |
| `deployments.connect.ingress.className` | Ingress class name | `"nginx"` |
| `deployments.connect.ingress.annotations.nginx.ingress.kubernetes.io/rewrite-target` | Configuration for io/rewrite-target | `"/"` |
| `deployments.connect.ingress.subdomain` | Subdomain for the service | `"webrix-connect"` |
| `deployments.connect.ingress.path` | Configuration for path | `"/"` |
| `deployments.connect.ingress.pathType` | Configuration for pathType | `"Prefix"` |
| `deployments.connect.ingress.tls` | Configuration for tls | `[]` |
| `deployments.run.enabled` | Enable run deployment | `True` |
| `deployments.run.replicas` | Number of pod replicas | `1` |
| `deployments.run.image.repository` | Container image repository | `"quay.io/webrix/mcp-s-run"` |
| `deployments.run.image.tag` | Container image tag | `"latest"` |
| `deployments.run.service.port` | Service port | `80` |
| `deployments.run.service.targetPort` | Container target port | `3000` |
| `deployments.run.resources.requests.cpu` | CPU resource request | `"100m"` |
| `deployments.run.resources.requests.memory` | Memory resource request | `"200Mi"` |
| `deployments.run.resources.limits.cpu` | CPU resource limit | `"1000m"` |
| `deployments.run.resources.limits.memory` | Memory resource limit | `"2048Mi"` |
| `deployments.run.nodeSelector` | Configuration for nodeSelector | `{}` |
| `deployments.run.tolerations` | Configuration for tolerations | `[]` |
| `deployments.run.affinity` | Configuration for affinity | `{}` |
| `deployments.run.podAnnotations` | Configuration for podAnnotations | `{}` |
| `deployments.run.podLabels` | Configuration for podLabels | `{}` |
| `deployments.run.serviceAccount.create` | Configuration for create | `True` |
| `deployments.run.serviceAccount.annotations` | Configuration for annotations | `{}` |
| `deployments.run.serviceAccount.name` | Configuration for name | `""` |
| `deployments.run.env.PORT` | Environment variable: PORT | `"3000"` |
| `deployments.run.env.LOG_LEVEL` | Environment variable: LOG_LEVEL | `"info"` |
| `deployments.run.env.AUTH_SECRET` | Environment variable: AUTH_SECRET | `"ZI39UlR2sN6HFZauuze0iNEZnNkF1wiOuGklm3bC8dk="` |
| `deployments.run.readinessProbe` | Configuration for readinessProbe | `{}` |
| `deployments.run.livenessProbe` | Configuration for livenessProbe | `{}` |
| `deployments.run.ingress.enabled` | Enable Ingress resource | `True` |
| `deployments.run.ingress.className` | Ingress class name | `"nginx"` |
| `deployments.run.ingress.annotations.nginx.ingress.kubernetes.io/rewrite-target` | Configuration for io/rewrite-target | `"/"` |
| `deployments.run.ingress.subdomain` | Subdomain for the service | `"webrix-run"` |
| `deployments.run.ingress.path` | Configuration for path | `"/"` |
| `deployments.run.ingress.pathType` | Configuration for pathType | `"Prefix"` |
| `deployments.run.ingress.tls` | Configuration for tls | `[]` |
| `deployments.dbService.enabled` | Enable dbService deployment | `True` |
| `deployments.dbService.replicas` | Number of pod replicas | `1` |
| `deployments.dbService.image.repository` | Container image repository | `"quay.io/webrix/mcp-s-db-service"` |
| `deployments.dbService.image.tag` | Container image tag | `"latest"` |
| `deployments.dbService.db.user` | Configuration for user | `"postgres"` |
| `deployments.dbService.db.password` | Configuration for password | `"postgres"` |
| `deployments.dbService.db.port` | Configuration for port | `5432` |
| `deployments.dbService.db.name` | Configuration for name | `"postgres"` |
| `deployments.dbService.service.port` | Service port | `80` |
| `deployments.dbService.service.targetPort` | Container target port | `3000` |
| `deployments.dbService.resources.requests.cpu` | CPU resource request | `"100m"` |
| `deployments.dbService.resources.requests.memory` | Memory resource request | `"200Mi"` |
| `deployments.dbService.resources.limits.cpu` | CPU resource limit | `"1000m"` |
| `deployments.dbService.resources.limits.memory` | Memory resource limit | `"2048Mi"` |
| `deployments.dbService.nodeSelector` | Configuration for nodeSelector | `{}` |
| `deployments.dbService.tolerations` | Configuration for tolerations | `[]` |
| `deployments.dbService.affinity` | Configuration for affinity | `{}` |
| `deployments.dbService.podAnnotations` | Configuration for podAnnotations | `{}` |
| `deployments.dbService.podLabels` | Configuration for podLabels | `{}` |
| `deployments.dbService.serviceAccount.create` | Configuration for create | `True` |
| `deployments.dbService.serviceAccount.annotations` | Configuration for annotations | `{}` |
| `deployments.dbService.serviceAccount.name` | Configuration for name | `""` |
| `deployments.dbService.env.PORT` | Environment variable: PORT | `"3000"` |
| `deployments.dbService.env.DEBUG_QUERIES` | Environment variable: DEBUG_QUERIES | `"true"` |
| `deployments.dbService.env.POSTGRES_HOST_AUTH_METHOD` | Environment variable: POSTGRES_HOST_AUTH_METHOD | `"trust"` |
| `deployments.dbService.env.RATE_LIMIT_MAX` | Environment variable: RATE_LIMIT_MAX | `"1000"` |
| `deployments.dbService.env.RATE_LIMIT_WINDOW` | Environment variable: RATE_LIMIT_WINDOW | `"60000"` |
| `deployments.dbService.env.AUTH_SECRET` | Environment variable: AUTH_SECRET | `"ZI39UlR2sN6HFZauuze0iNEZnNkF1wiOuGklm3bC8dk="` |
| `deployments.dbService.env.AUTO_AUTHENTICATE_TOKEN` | Environment variable: AUTO_AUTHENTICATE_TOKEN | `"balQgAqCpKW979XoibTYSbfCjvj7uSJK+90m0iQG5"` |
| `deployments.dbService.env.ENCRYPTION_KEY` | Environment variable: ENCRYPTION_KEY | `"iL7wUJhqRMPFY0asXqLAn1JjW9kv0OqC4NHtqKHt5VY="` |
| `deployments.dbService.readinessProbe.httpGet.path` | Configuration for path | `"/readyz"` |
| `deployments.dbService.readinessProbe.httpGet.port` | Configuration for port | `3000` |
| `deployments.dbService.readinessProbe.initialDelaySeconds` | Configuration for initialDelaySeconds | `10` |
| `deployments.dbService.readinessProbe.periodSeconds` | Configuration for periodSeconds | `5` |
| `deployments.dbService.readinessProbe.timeoutSeconds` | Configuration for timeoutSeconds | `5` |
| `deployments.dbService.readinessProbe.failureThreshold` | Configuration for failureThreshold | `10` |
| `deployments.dbService.livenessProbe.httpGet.path` | Configuration for path | `"/healthz"` |
| `deployments.dbService.livenessProbe.httpGet.port` | Configuration for port | `3000` |
| `deployments.dbService.livenessProbe.initialDelaySeconds` | Configuration for initialDelaySeconds | `30` |
| `deployments.dbService.livenessProbe.periodSeconds` | Configuration for periodSeconds | `10` |
| `deployments.dbService.livenessProbe.timeoutSeconds` | Configuration for timeoutSeconds | `5` |
| `deployments.dbService.livenessProbe.failureThreshold` | Configuration for failureThreshold | `3` |
| `deployments.dbService.ingress.enabled` | Enable Ingress resource | `False` |
| `postgresql.enabled` | Enable postgresql deployment | `False` |
| `postgresql.global.security.allowInsecureImages` | Configuration for allowInsecureImages | `True` |
| `postgresql.fullnameOverride` | Configuration for fullnameOverride | `"webrix-postgresql"` |
| `postgresql.image.registry` | Configuration for registry | `"docker.io"` |
| `postgresql.image.repository` | Container image repository | `"bitnamilegacy/postgresql"` |
| `postgresql.image.tag` | Container image tag | `"17.6.0"` |
| `postgresql.auth.enablePostgresUser` | Configuration for enablePostgresUser | `True` |
| `postgresql.auth.postgresPassword` | Password for 'postgres' user | `"postgres"` |
| `postgresql.primary.resourcesPreset` | Configuration for resourcesPreset | `"small"` |
| `postgresql.primary.persistence.enabled` | Enable persistent storage | `True` |
| `postgresql.primary.persistence.size` | Size of persistent volume | `"8Gi"` |
| `postgresql.primary.persistence.storageClass` | Configuration for storageClass | `""` |
| `postgresql.readReplicas.replicaCount` | Configuration for replicaCount | `0` |
| `postgresql.service.ports.postgresql` | Service port | `5432` |
| `postgresql.metrics.enabled` | Configuration for enabled | `False` |
| `postgresql.architecture` | Configuration for architecture | `"standalone"` |
| `postgresql.postgresqlConfiguration.listen_addresses` | Configuration for listen_addresses | `"'*'"` |
| `postgresql.postgresqlConfiguration.max_connections` | Configuration for max_connections | `"200"` |
| `externalDatabase.url` | Configuration for url | `""` |
| `externalDatabase.host` | Configuration for host | `""` |
| `externalDatabase.port` | Configuration for port | `5432` |
| `externalDatabase.database` | Configuration for database | `"postgres"` |
| `externalDatabase.username` | Configuration for username | `"postgres"` |
| `externalDatabase.password` | Configuration for password | `""` |
| `externalDatabase.sslMode` | Configuration for sslMode | `"disable"` |
