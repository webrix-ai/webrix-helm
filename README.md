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
   helm install webrix-helm .
   ```

2. **Install with minimal values:**
   ```bash
   helm install webrix-helm . --values values-minimal.yaml
   ```

3. **Install with custom values:**
   ```bash
   helm install webrix-helm . -f custom-values.yaml
   ```

4. **Install with specific overrides:**
   ```bash
   helm install webrix-helm . \
     --namespace my-namespace \
     --set global.domain.host=my-domain.com \
     --set deployments.app.replicas=3
   ```

## Configuration

### Global Settings

```yaml
global:
  db_provider: "postgresql"  # or "external"
  domain:
    host: "webrix.local"
  labels: {}
  annotations: {}
```

### Service Configuration

Each service can be configured independently under `deployments`:

```yaml
deployments:
  app:
    enabled: true
    replicas: 1
    image:
      repository: "quay.io/idan-chetrit/mcp-s-app"
      tag: "latest"
      pullPolicy: "IfNotPresent"
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
      ON_PREM: "true"
    ingress:
      enabled: true
      subdomain: "webrix-app"
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

Each service has its own ingress configuration:

```yaml
deployments:
  app:
    ingress:
      enabled: true
      className: "nginx"
      subdomain: "webrix-app"
      path: "/"
      pathType: "Prefix"
      annotations:
        nginx.ingress.kubernetes.io/rewrite-target: /
  connect:
    ingress:
      enabled: true
      subdomain: "webrix-connect"
  run:
    ingress:
      enabled: true
      subdomain: "webrix-run"
  dbService:
    ingress:
      enabled: true
      subdomain: "webrix-dbservice"
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
Each service can have its own environment variables in the `deployments.<service>.env` section.

### Dynamic URL Generation
The chart automatically generates URLs for inter-service communication:
- `BASE_URL`: Points to the current service's URL
- `NEXTAUTH_URL`: Points to the current service's URL  
- `CONNECT_URL`: Points to the connect service
- `RUN_URL`: Points to the run service
- `DB_SERVICE_URL`: Points to the dbService
- `NEXT_PUBLIC_CONNECT_URL`: Points to the connect service

These URLs are automatically generated based on `global.domain.host` and service ingress subdomains.

## Examples

### Minimal Installation
Use the `values-minimal.yaml` file for a quick start with minimal configuration:

```bash
helm install webrix-helm . --values values-minimal.yaml
```

### Production Installation
For production deployments, customize the values.yaml file:

```bash
helm install webrix-helm . --values values.yaml --namespace webrix-prod
```

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
