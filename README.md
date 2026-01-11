# Webrix Helm Chart

This is a unified Helm chart that orchestrates the deployment of the Webrix stack on Kubernetes. It manages the following services:

- **App**: The main application interface.
- **Connect**: The connection service.
- **Run**: The runtime execution service.
- **db-service**: The database service layer.
- **PostgreSQL**: Optional in-cluster database (powered by Bitnami).

This chart provides a flexible configuration to deploy either a full stack with an internal database or connect to an external PostgreSQL instance.

## Installation

### Prerequisites

Since you're using private container images, you'll need to create an image pull secret first:

```bash
kubectl create secret docker-registry webrix-registry \
  --namespace <namespace> \
  --docker-server=quay.io \
  --docker-username=<robot-username> \
  --docker-password=<robot-token> \
  --docker-email=unused@webrix.io
```

### Install the Chart

To install the chart with the release name :

To install with a custom values file:

## Configuration

The following table lists the configurable parameters of the Webrix chart and their default values.

### Configuration Parameters

The following table lists the configurable parameters of the Webrix chart and their default values.

#### Global Configuration

| Key                       | Description                                                                               | Default                                          |
| ------------------------- | ----------------------------------------------------------------------------------------- | ------------------------------------------------ |
| `global.db_provider`      | Database provider: `postgresql` for in-cluster db, or `external` for external db          | `"postgresql"`                                   |
| `global.external_db_url`  | Full URL for external database connection (alternative to externalDatabase configuration) | `""`                                             |
| `global.domain.host`      | Base domain for all services                                                              | `"example.com"`                                  |
| `global.ON_PREM`          | Enable on-premises mode                                                                   | `true`                                           |
| `global.ORG`              | Organization identifier                                                                   | `"on-prem-org"`                                  |
| `global.authSecret`       | Global authentication secret                                                              | `"aUi2V5iCVqUrbrdjKty1zH4HCqszXArV9BLVU2giqhY="` |
| `global.dbAuthSecret`     | Database authentication secret                                                            | `"ZI39UlR2sN6HFZauuze0iNEZnNkF1wiOuGklm3bC8dk="` |
| `global.labels`           | Common labels applied to all resources                                                    | `{}`                                             |
| `global.annotations`      | Common annotations applied to all resources                                               | `{}`                                             |
| `global.imagePullSecrets` | Image pull secrets for private container registries                                       | `[{name: "webrix-registry"}]`                    |
| `global.sharedEnv`        | Environment variables shared across all deployments                                       | `{}`                                             |

#### App Service Configuration

| Key                                          | Description                                    | Default                                             |
| -------------------------------------------- | ---------------------------------------------- | --------------------------------------------------- |
| `deployments.app.enabled`                    | Enable app deployment                          | `true`                                              |
| `deployments.app.replicas`                   | Number of pod replicas                         | `1`                                                 |
| `deployments.app.image.repository`           | Container image repository                     | `"quay.io/webrix/mcp-s-app"`                        |
| `deployments.app.image.tag`                  | Container image tag                            | `"latest"`                                          |
| `deployments.app.service.port`               | Service port                                   | `80`                                                |
| `deployments.app.service.targetPort`         | Container target port                          | `3000`                                              |
| `deployments.app.resources.requests.cpu`     | CPU resource request                           | `"100m"`                                            |
| `deployments.app.resources.requests.memory`  | Memory resource request                        | `"256Mi"`                                           |
| `deployments.app.resources.limits.cpu`       | CPU resource limit                             | `"1000m"`                                           |
| `deployments.app.resources.limits.memory`    | Memory resource limit                          | `"2048Mi"`                                          |
| `deployments.app.nodeSelector`               | Node selector for pod assignment               | `{}`                                                |
| `deployments.app.tolerations`                | Tolerations for pod assignment                 | `[]`                                                |
| `deployments.app.affinity`                   | Affinity rules for pod assignment              | `{}`                                                |
| `deployments.app.podAnnotations`             | Annotations to add to pods                     | `{}`                                                |
| `deployments.app.podLabels`                  | Labels to add to pods                          | `{}`                                                |
| `deployments.app.serviceAccount.create`      | Create service account                         | `true`                                              |
| `deployments.app.serviceAccount.annotations` | Service account annotations                    | `{}`                                                |
| `deployments.app.serviceAccount.name`        | Service account name (auto-generated if empty) | `""`                                                |
| `deployments.app.env.PORT`                   | Service port environment variable              | `"3000"`                                            |
| `deployments.app.readinessProbe`             | Readiness probe configuration                  | `{}`                                                |
| `deployments.app.livenessProbe`              | Liveness probe configuration                   | `{}`                                                |
| `deployments.app.ingress.enabled`            | Enable Ingress resource                        | `true`                                              |
| `deployments.app.ingress.className`          | Ingress class name                             | `"nginx"`                                           |
| `deployments.app.ingress.annotations`        | Ingress annotations                            | `{nginx.ingress.kubernetes.io/rewrite-target: "/"}` |
| `deployments.app.ingress.subdomain`          | Subdomain for the service                      | `"webrix-admin"`                                    |
| `deployments.app.ingress.path`               | Ingress path                                   | `"/"`                                               |
| `deployments.app.ingress.pathType`           | Ingress path type                              | `"Prefix"`                                          |
| `deployments.app.ingress.tls`                | TLS configuration                              | `[]`                                                |

#### Connect Service Configuration

| Key                                              | Description                                    | Default                                             |
| ------------------------------------------------ | ---------------------------------------------- | --------------------------------------------------- |
| `deployments.connect.enabled`                    | Enable connect deployment                      | `true`                                              |
| `deployments.connect.replicas`                   | Number of pod replicas                         | `1`                                                 |
| `deployments.connect.image.repository`           | Container image repository                     | `"quay.io/webrix/mcp-s-connect"`                    |
| `deployments.connect.image.tag`                  | Container image tag                            | `"latest"`                                          |
| `deployments.connect.service.port`               | Service port                                   | `80`                                                |
| `deployments.connect.service.targetPort`         | Container target port                          | `3000`                                              |
| `deployments.connect.resources.requests.cpu`     | CPU resource request                           | `"500m"`                                            |
| `deployments.connect.resources.requests.memory`  | Memory resource request                        | `"500Mi"`                                           |
| `deployments.connect.resources.limits.cpu`       | CPU resource limit                             | `"1000m"`                                           |
| `deployments.connect.resources.limits.memory`    | Memory resource limit                          | `"4048Mi"`                                          |
| `deployments.connect.nodeSelector`               | Node selector for pod assignment               | `{}`                                                |
| `deployments.connect.tolerations`                | Tolerations for pod assignment                 | `[]`                                                |
| `deployments.connect.affinity`                   | Affinity rules for pod assignment              | `{}`                                                |
| `deployments.connect.podAnnotations`             | Annotations to add to pods                     | `{}`                                                |
| `deployments.connect.podLabels`                  | Labels to add to pods                          | `{}`                                                |
| `deployments.connect.serviceAccount.create`      | Create service account                         | `true`                                              |
| `deployments.connect.serviceAccount.annotations` | Service account annotations                    | `{}`                                                |
| `deployments.connect.serviceAccount.name`        | Service account name (auto-generated if empty) | `""`                                                |
| `deployments.connect.env.PORT`                   | Service port environment variable              | `"3000"`                                            |
| `deployments.connect.env.AUTH_TRUST_HOST`        | Enable auth trust host                         | `"true"`                                            |
| `deployments.connect.readinessProbe`             | Readiness probe configuration                  | `{}`                                                |
| `deployments.connect.livenessProbe`              | Liveness probe configuration                   | `{}`                                                |
| `deployments.connect.ingress.enabled`            | Enable Ingress resource                        | `true`                                              |
| `deployments.connect.ingress.className`          | Ingress class name                             | `"nginx"`                                           |
| `deployments.connect.ingress.annotations`        | Ingress annotations                            | `{nginx.ingress.kubernetes.io/rewrite-target: "/"}` |
| `deployments.connect.ingress.subdomain`          | Subdomain for the service                      | `"webrix-dashboard"`                                |
| `deployments.connect.ingress.path`               | Ingress path                                   | `"/"`                                               |
| `deployments.connect.ingress.pathType`           | Ingress path type                              | `"Prefix"`                                          |
| `deployments.connect.ingress.tls`                | TLS configuration                              | `[]`                                                |

#### Run Service Configuration

| Key                                          | Description                                    | Default                                             |
| -------------------------------------------- | ---------------------------------------------- | --------------------------------------------------- |
| `deployments.run.enabled`                    | Enable run deployment                          | `true`                                              |
| `deployments.run.replicas`                   | Number of pod replicas                         | `4`                                                 |
| `deployments.run.image.repository`           | Container image repository                     | `"quay.io/webrix/mcp-s-run"`                        |
| `deployments.run.image.tag`                  | Container image tag                            | `"latest"`                                          |
| `deployments.run.service.port`               | Service port                                   | `80`                                                |
| `deployments.run.service.targetPort`         | Container target port                          | `3000`                                              |
| `deployments.run.resources.requests.cpu`     | CPU resource request                           | `"1000m"`                                           |
| `deployments.run.resources.requests.memory`  | Memory resource request                        | `"500Mi"`                                           |
| `deployments.run.resources.limits.cpu`       | CPU resource limit                             | `"2000m"`                                           |
| `deployments.run.resources.limits.memory`    | Memory resource limit                          | `"8192Mi"`                                          |
| `deployments.run.nodeSelector`               | Node selector for pod assignment               | `{}`                                                |
| `deployments.run.tolerations`                | Tolerations for pod assignment                 | `[]`                                                |
| `deployments.run.affinity`                   | Affinity rules for pod assignment              | `{}`                                                |
| `deployments.run.podAnnotations`             | Annotations to add to pods                     | `{}`                                                |
| `deployments.run.podLabels`                  | Labels to add to pods                          | `{}`                                                |
| `deployments.run.serviceAccount.create`      | Create service account                         | `true`                                              |
| `deployments.run.serviceAccount.annotations` | Service account annotations                    | `{}`                                                |
| `deployments.run.serviceAccount.name`        | Service account name (auto-generated if empty) | `""`                                                |
| `deployments.run.env.PORT`                   | Service port environment variable              | `"3000"`                                            |
| `deployments.run.env.LOG_LEVEL`              | Logging level                                  | `"info"`                                            |
| `deployments.run.readinessProbe`             | Readiness probe configuration                  | `{}`                                                |
| `deployments.run.livenessProbe`              | Liveness probe configuration                   | `{}`                                                |
| `deployments.run.ingress.enabled`            | Enable Ingress resource                        | `true`                                              |
| `deployments.run.ingress.className`          | Ingress class name                             | `"nginx"`                                           |
| `deployments.run.ingress.annotations`        | Ingress annotations                            | `{nginx.ingress.kubernetes.io/rewrite-target: "/"}` |
| `deployments.run.ingress.subdomain`          | Subdomain for the service                      | `"webrix"`                                          |
| `deployments.run.ingress.path`               | Ingress path                                   | `"/"`                                               |
| `deployments.run.ingress.pathType`           | Ingress path type                              | `"Prefix"`                                          |
| `deployments.run.ingress.tls`                | TLS configuration                              | `[]`                                                |

#### DB Service Configuration

| Key                                                         | Description                                    | Default                                          |
| ----------------------------------------------------------- | ---------------------------------------------- | ------------------------------------------------ |
| `deployments.db-service.enabled`                            | Enable db-service deployment                   | `true`                                           |
| `deployments.db-service.replicas`                           | Number of pod replicas                         | `3`                                              |
| `deployments.db-service.image.repository`                   | Container image repository                     | `"quay.io/webrix/mcp-s-db-service"`              |
| `deployments.db-service.image.tag`                          | Container image tag                            | `"latest"`                                       |
| `deployments.db-service.db.user`                            | Database user                                  | `"postgres"`                                     |
| `deployments.db-service.db.password`                        | Database password                              | `"postgres"`                                     |
| `deployments.db-service.db.port`                            | Database port                                  | `5432`                                           |
| `deployments.db-service.db.name`                            | Database name                                  | `"postgres"`                                     |
| `deployments.db-service.service.port`                       | Service port                                   | `80`                                             |
| `deployments.db-service.service.targetPort`                 | Container target port                          | `3000`                                           |
| `deployments.db-service.resources.requests.cpu`             | CPU resource request                           | `"1000m"`                                        |
| `deployments.db-service.resources.requests.memory`          | Memory resource request                        | `"500Mi"`                                        |
| `deployments.db-service.resources.limits.cpu`               | CPU resource limit                             | `"2000m"`                                        |
| `deployments.db-service.resources.limits.memory`            | Memory resource limit                          | `"8192Mi"`                                       |
| `deployments.db-service.nodeSelector`                       | Node selector for pod assignment               | `{}`                                             |
| `deployments.db-service.tolerations`                        | Tolerations for pod assignment                 | `[]`                                             |
| `deployments.db-service.affinity`                           | Affinity rules for pod assignment              | `{}`                                             |
| `deployments.db-service.podAnnotations`                     | Annotations to add to pods                     | `{}`                                             |
| `deployments.db-service.podLabels`                          | Labels to add to pods                          | `{}`                                             |
| `deployments.db-service.serviceAccount.create`              | Create service account                         | `true`                                           |
| `deployments.db-service.serviceAccount.annotations`         | Service account annotations                    | `{}`                                             |
| `deployments.db-service.serviceAccount.name`                | Service account name (auto-generated if empty) | `""`                                             |
| `deployments.db-service.env.PORT`                           | Service port environment variable              | `"3000"`                                         |
| `deployments.db-service.env.POSTGRES_HOST_AUTH_METHOD`      | PostgreSQL authentication method               | `"trust"`                                        |
| `deployments.db-service.env.RATE_LIMIT_MAX`                 | Maximum rate limit requests                    | `"1000"`                                         |
| `deployments.db-service.env.RATE_LIMIT_WINDOW`              | Rate limit window in milliseconds              | `"60000"`                                        |
| `deployments.db-service.env.AUTO_AUTHENTICATE_TOKEN`        | Auto authentication token                      | `"balQgAqCpKW979XoibTYSbfCjvj7uSJK+90m0iQG5"`    |
| `deployments.db-service.env.ENCRYPTION_KEY`                 | Encryption key for data                        | `"iL7wUJhqRMPFY0asXqLAn1JjW9kv0OqC4NHtqKHt5VY="` |
| `deployments.db-service.readinessProbe.httpGet.path`        | Readiness probe HTTP path                      | `"/readyz"`                                      |
| `deployments.db-service.readinessProbe.httpGet.port`        | Readiness probe HTTP port                      | `3000`                                           |
| `deployments.db-service.readinessProbe.initialDelaySeconds` | Readiness probe initial delay                  | `10`                                             |
| `deployments.db-service.readinessProbe.periodSeconds`       | Readiness probe period                         | `5`                                              |
| `deployments.db-service.readinessProbe.timeoutSeconds`      | Readiness probe timeout                        | `5`                                              |
| `deployments.db-service.readinessProbe.failureThreshold`    | Readiness probe failure threshold              | `10`                                             |
| `deployments.db-service.livenessProbe.httpGet.path`         | Liveness probe HTTP path                       | `"/healthz"`                                     |
| `deployments.db-service.livenessProbe.httpGet.port`         | Liveness probe HTTP port                       | `3000`                                           |
| `deployments.db-service.livenessProbe.initialDelaySeconds`  | Liveness probe initial delay                   | `30`                                             |
| `deployments.db-service.livenessProbe.periodSeconds`        | Liveness probe period                          | `10`                                             |
| `deployments.db-service.livenessProbe.timeoutSeconds`       | Liveness probe timeout                         | `5`                                              |
| `deployments.db-service.livenessProbe.failureThreshold`     | Liveness probe failure threshold               | `3`                                              |
| `deployments.db-service.ingress.enabled`                    | Enable Ingress resource                        | `false`                                          |

#### PostgreSQL Configuration

| Key                                                   | Description                             | Default                      |
| ----------------------------------------------------- | --------------------------------------- | ---------------------------- |
| `postgresql.enabled`                                  | Enable in-cluster PostgreSQL deployment | `false`                      |
| `postgresql.global.security.allowInsecureImages`      | Allow insecure images                   | `true`                       |
| `postgresql.fullnameOverride`                         | Override full name                      | `"webrix-postgresql"`        |
| `postgresql.image.registry`                           | PostgreSQL image registry               | `"docker.io"`                |
| `postgresql.image.repository`                         | PostgreSQL image repository             | `"bitnamilegacy/postgresql"` |
| `postgresql.image.tag`                                | PostgreSQL image tag                    | `"17.6.0"`                   |
| `postgresql.auth.enablePostgresUser`                  | Enable 'postgres' superuser             | `true`                       |
| `postgresql.auth.postgresPassword`                    | Password for 'postgres' user            | `"postgres"`                 |
| `postgresql.primary.resourcesPreset`                  | Resource preset for primary             | `"small"`                    |
| `postgresql.primary.persistence.enabled`              | Enable persistent storage               | `true`                       |
| `postgresql.primary.persistence.size`                 | Size of persistent volume               | `"8Gi"`                      |
| `postgresql.primary.persistence.storageClass`         | Storage class (empty = default)         | `""`                         |
| `postgresql.readReplicas.replicaCount`                | Number of read replicas                 | `0`                          |
| `postgresql.service.ports.postgresql`                 | PostgreSQL service port                 | `5432`                       |
| `postgresql.metrics.enabled`                          | Enable metrics exporter                 | `false`                      |
| `postgresql.architecture`                             | PostgreSQL architecture mode            | `"standalone"`               |
| `postgresql.postgresqlConfiguration.listen_addresses` | PostgreSQL listen addresses             | `"'*'"`                      |
| `postgresql.postgresqlConfiguration.max_connections`  | Maximum connections                     | `"200"`                      |

#### External Database Configuration

| Key                         | Description                    | Default      |
| --------------------------- | ------------------------------ | ------------ |
| `externalDatabase.url`      | Complete external database URL | `""`         |
| `externalDatabase.host`     | External database host         | `""`         |
| `externalDatabase.port`     | External database port         | `5432`       |
| `externalDatabase.database` | External database name         | `"postgres"` |
| `externalDatabase.username` | External database username     | `"postgres"` |
| `externalDatabase.password` | External database password     | `""`         |
| `externalDatabase.sslMode`  | SSL mode for connection        | `"disable"`  |
