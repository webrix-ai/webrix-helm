# Webrix Helm Chart

This is a unified Helm chart that combines all Webrix services (app, connect, run, db-service) into a single deployable chart.

## Services

- **app**: Main application service
- **connect**: Authentication/connection service
- **run**: Runtime execution service
- **db-service**: Database service layer
- **PostgreSQL**: Optional in-cluster database (via Bitnami chart)

## Quick Start

1. **Install the chart with default values:**
   ```bash
   helm install webrix-helm ./charts/webrix-helm
   ```

2. **Install with custom values:**
   ```bash
   helm install mcp-s ./charts/webrix-helm -f custom-values.yaml
   ```

3. **Install with specific overrides:**
   ```bash
   helm install mcp-s ./charts/webrix-helm \
     --namespace my-namespace \
     --set ingress.host=my-domain.com \
     --set services.app.replicas=3
   ```

## Configuration

### Global Settings

```yaml
global:
  db_provider: "postgresql"  # or "external"
  labels: {}
  annotations: {}
```

### Service Configuration

Each service can be configured independently:

```yaml
services:
  app:
    enabled: true
    replicas: 1
    image:
      repository: "quay.io/idan-chetrit/mcp-s-app"
      tag: "latest"
    resources:
      requests:
        cpu: 100m
        memory: 200Mi
      limits:
        cpu: 1000m
        memory: 2048Mi
    env:
      PORT: "3000"
      ORG: "on-prem-org"
```

### Database Configuration

#### In-cluster PostgreSQL (default)
```yaml
global:
  db_provider: "postgresql"

postgresql:
  enabled: true
  auth:
    postgresPassword: "postgres"
  primary:
    persistence:
      enabled: true
      size: 8Gi
```

#### External Database
```yaml
global:
  db_provider: "external"

postgresql:
  enabled: false

externalDatabase:
  host: "your-db-host"
  port: 5432
  database: "postgres"
  username: "postgres"
  password: "your-password"
```

### Ingress Configuration

```yaml
ingress:
  enabled: true
  className: "nginx"
  host: "mcp-s.com"
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /

services:
  app:
    ingress:
      enabled: true
      subdomain: "app"
  connect:
    ingress:
      enabled: true
      subdomain: "connect"
  run:
    ingress:
      enabled: true
      subdomain: "run"
```

## Environment Variables

### Shared Environment Variables
```yaml
sharedEnv:
  AUTH_SECRET: "your-auth-secret"
  DB_AUTH_SECRET: "your-db-auth-secret"
  AUTO_AUTHENTICATE_TOKEN: "your-token"
  ENCRYPTION_KEY: "your-encryption-key"
```

### Service-specific Environment Variables
Each service can have its own environment variables in the `services.<service>.env` section.

## Examples

## Troubleshooting

### Common Issues

1. **Database Connection Issues**
   - Verify `global.db_provider` is set correctly
   - Check database credentials and connection strings
   - Ensure PostgreSQL is running if using in-cluster database

2. **Service Communication Issues**
   - Verify all services are in the same namespace
   - Check service names and ports
   - Ensure DNS resolution is working

3. **Ingress Issues**
   - Verify ingress controller is installed
   - Check ingress class and annotations
   - Ensure DNS is pointing to your cluster


## Values Reference

See the `values.yaml` file for a complete list of configurable values with their descriptions and default values.
