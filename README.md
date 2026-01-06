# Webrix Helm Chart

This is a unified Helm chart that orchestrates the deployment of the Webrix stack on Kubernetes. It manages the following services:

- **App**: The main application interface.
- **Connect**: The connection service.
- **Run**: The runtime execution service.
- **db-service**: The database service layer.
- **PostgreSQL**: Optional in-cluster database (powered by Bitnami).

This chart provides a flexible configuration to deploy either a full stack with an internal database or connect to an external PostgreSQL instance.

## Installation

To install the chart with the release name :

To install with a custom values file:

## Configuration

The following table lists the configurable parameters of the Webrix chart and their default values.

| Key | Description                                         | Default |
| --- | --------------------------------------------------- | ------- |
|     | Database provider ('postgresql' or 'external')      |         |
|     | Full URL for external database connection           |         |
|     | Base domain for all services                        |         |
|     | Configuration for ON_PREM                           |         |
|     | Configuration for ORG                               |         |
|     | Configuration for labels                            |         |
|     | Configuration for annotations                       |         |
|     | Environment variables shared across all deployments |         |
|     | Enable app deployment                               |         |
|     | Number of pod replicas                              |         |
|     | Container image repository                          |         |
|     | Container image tag                                 |         |
|     | Service port                                        |         |
|     | Container target port                               |         |
|     | CPU resource request                                |         |
|     | Memory resource request                             |         |
|     | CPU resource limit                                  |         |
|     | Memory resource limit                               |         |
|     | Configuration for nodeSelector                      |         |
|     | Configuration for tolerations                       |         |
|     | Configuration for affinity                          |         |
|     | Configuration for podAnnotations                    |         |
|     | Configuration for podLabels                         |         |
|     | Configuration for create                            |         |
|     | Configuration for annotations                       |         |
|     | Configuration for name                              |         |
|     | Environment variable: PORT                          |         |
|     | Environment variable: DB_AUTH_SECRET                |         |
|     | Environment variable: AUTH_SECRET                   |         |
|     | Configuration for readinessProbe                    |         |
|     | Configuration for livenessProbe                     |         |
|     | Enable Ingress resource                             |         |
|     | Ingress class name                                  |         |
|     | Configuration for io/rewrite-target                 |         |
|     | Subdomain for the service                           |         |
|     | Configuration for path                              |         |
|     | Configuration for pathType                          |         |
|     | Configuration for tls                               |         |
|     | Enable connect deployment                           |         |
|     | Number of pod replicas                              |         |
|     | Container image repository                          |         |
|     | Container image tag                                 |         |
|     | Service port                                        |         |
|     | Container target port                               |         |
|     | CPU resource request                                |         |
|     | Memory resource request                             |         |
|     | CPU resource limit                                  |         |
|     | Memory resource limit                               |         |
|     | Configuration for nodeSelector                      |         |
|     | Configuration for tolerations                       |         |
|     | Configuration for affinity                          |         |
|     | Configuration for podAnnotations                    |         |
|     | Configuration for podLabels                         |         |
|     | Configuration for create                            |         |
|     | Configuration for annotations                       |         |
|     | Configuration for name                              |         |
|     | Environment variable: PORT                          |         |
|     | Environment variable: DEBUG                         |         |
|     | Environment variable: AUTH_TRUST_HOST               |         |
|     | Environment variable: DB_AUTH_SECRET                |         |
|     | Environment variable: AUTH_SECRET                   |         |
|     | Configuration for readinessProbe                    |         |
|     | Configuration for livenessProbe                     |         |
|     | Enable Ingress resource                             |         |
|     | Ingress class name                                  |         |
|     | Configuration for io/rewrite-target                 |         |
|     | Subdomain for the service                           |         |
|     | Configuration for path                              |         |
|     | Configuration for pathType                          |         |
|     | Configuration for tls                               |         |
|     | Enable run deployment                               |         |
|     | Number of pod replicas                              |         |
|     | Container image repository                          |         |
|     | Container image tag                                 |         |
|     | Service port                                        |         |
|     | Container target port                               |         |
|     | CPU resource request                                |         |
|     | Memory resource request                             |         |
|     | CPU resource limit                                  |         |
|     | Memory resource limit                               |         |
|     | Configuration for nodeSelector                      |         |
|     | Configuration for tolerations                       |         |
|     | Configuration for affinity                          |         |
|     | Configuration for podAnnotations                    |         |
|     | Configuration for podLabels                         |         |
|     | Configuration for create                            |         |
|     | Configuration for annotations                       |         |
|     | Configuration for name                              |         |
|     | Environment variable: PORT                          |         |
|     | Environment variable: LOG_LEVEL                     |         |
|     | Environment variable: AUTH_SECRET                   |         |
|     | Configuration for readinessProbe                    |         |
|     | Configuration for livenessProbe                     |         |
|     | Enable Ingress resource                             |         |
|     | Ingress class name                                  |         |
|     | Configuration for io/rewrite-target                 |         |
|     | Subdomain for the service                           |         |
|     | Configuration for path                              |         |
|     | Configuration for pathType                          |         |
|     | Configuration for tls                               |         |
|     | Enable db-service deployment                        |         |
|     | Number of pod replicas                              |         |
|     | Container image repository                          |         |
|     | Container image tag                                 |         |
|     | Configuration for user                              |         |
|     | Configuration for password                          |         |
|     | Configuration for port                              |         |
|     | Configuration for name                              |         |
|     | Service port                                        |         |
|     | Container target port                               |         |
|     | CPU resource request                                |         |
|     | Memory resource request                             |         |
|     | CPU resource limit                                  |         |
|     | Memory resource limit                               |         |
|     | Configuration for nodeSelector                      |         |
|     | Configuration for tolerations                       |         |
|     | Configuration for affinity                          |         |
|     | Configuration for podAnnotations                    |         |
|     | Configuration for podLabels                         |         |
|     | Configuration for create                            |         |
|     | Configuration for annotations                       |         |
|     | Configuration for name                              |         |
|     | Environment variable: PORT                          |         |
|     | Environment variable: DEBUG_QUERIES                 |         |
|     | Environment variable: POSTGRES_HOST_AUTH_METHOD     |         |
|     | Environment variable: RATE_LIMIT_MAX                |         |
|     | Environment variable: RATE_LIMIT_WINDOW             |         |
|     | Environment variable: AUTH_SECRET                   |         |
|     | Environment variable: AUTO_AUTHENTICATE_TOKEN       |         |
|     | Environment variable: ENCRYPTION_KEY                |         |
|     | Configuration for path                              |         |
|     | Configuration for port                              |         |
|     | Configuration for initialDelaySeconds               |         |
|     | Configuration for periodSeconds                     |         |
|     | Configuration for timeoutSeconds                    |         |
|     | Configuration for failureThreshold                  |         |
|     | Configuration for path                              |         |
|     | Configuration for port                              |         |
|     | Configuration for initialDelaySeconds               |         |
|     | Configuration for periodSeconds                     |         |
|     | Configuration for timeoutSeconds                    |         |
|     | Configuration for failureThreshold                  |         |
|     | Enable Ingress resource                             |         |
|     | Enable postgresql deployment                        |         |
|     | Configuration for allowInsecureImages               |         |
|     | Configuration for fullnameOverride                  |         |
|     | Configuration for registry                          |         |
|     | Container image repository                          |         |
|     | Container image tag                                 |         |
|     | Configuration for enablePostgresUser                |         |
|     | Password for 'postgres' user                        |         |
|     | Configuration for resourcesPreset                   |         |
|     | Enable persistent storage                           |         |
|     | Size of persistent volume                           |         |
|     | Configuration for storageClass                      |         |
|     | Configuration for replicaCount                      |         |
|     | Service port                                        |         |
|     | Configuration for enabled                           |         |
|     | Configuration for architecture                      |         |
|     | Configuration for listen_addresses                  |         |
|     | Configuration for max_connections                   |         |
|     | Configuration for url                               |         |
|     | Configuration for host                              |         |
|     | Configuration for port                              |         |
|     | Configuration for database                          |         |
|     | Configuration for username                          |         |
|     | Configuration for password                          |         |
|     | Configuration for sslMode                           |         |
