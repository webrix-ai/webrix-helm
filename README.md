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

### Sealed Secrets Support
The chart supports SealedSecret resources alongside regular secrets for sensitive data. Use `envsubst` to substitute environment variables before installation:

```yaml
deployments:
  app:
    sealedSecrets:
      API_KEY: ${{ secrets.API_KEY }}
      DATABASE_PASSWORD: ${{ secrets.DB_PASSWORD }}
      JWT_SECRET: ${{ secrets.JWT_SECRET }}
```

**Prerequisites:**
- Sealed Secrets operator must be installed in your cluster
- Public key must be available for encryption

**Usage:**
1. Set environment variables: `export API_KEY="your-secret-key"`
2. Process values file: `envsubst < values.yaml > values-processed.yaml`
3. Install chart: `helm install webrix . -f values-processed.yaml`

**How it works:**
- Chart creates **SealedSecret** resources (named `{service}-sealed-secret`)
- Sealed Secrets operator **automatically decrypts** them
- Creates regular **Kubernetes secrets** (named `{service}-secret`)
- Pods mount secrets as **environment variables**

**Note:** Both regular secrets and SealedSecrets can be used simultaneously. Regular secrets are always created, SealedSecrets are only created when `sealedSecrets` is defined.

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

2. **Ingress Issues**
   - Verify ingress controller is installed
   - Check ingress class and annotations
   - Ensure DNS is pointing to your cluster


## Values Reference

### Global Configuration

| Parameter | Default | Description |
|-----------|---------|-------------|
| `global.db_provider` | `"postgresql"` | Database provider: "postgresql" for in-cluster or "external" for external |
| `global.domain.host` | `"blahblah.com"` | Global domain for all services |
| `global.labels` | `{}` | Common labels applied to all resources |
| `global.annotations` | `{}` | Common annotations applied to all resources |

### Service Configuration

| Parameter | Default | Description |
|-----------|---------|-------------|
| `deployments.<service>.enabled` | `true` | Enable/disable the service |
| `deployments.<service>.replicas` | `1` | Number of replicas |
| `deployments.<service>.image.repository` | Service-specific | Container image repository |
| `deployments.<service>.image.tag` | `"latest"` | Container image tag |
| `deployments.<service>.image.pullPolicy` | `"IfNotPresent"` | Image pull policy |
| `deployments.<service>.service.type` | `"ClusterIP"` | Kubernetes service type |
| `deployments.<service>.service.port` | `80` | Service port |
| `deployments.<service>.service.targetPort` | `3000` | Container port |
| `deployments.<service>.resources.requests.cpu` | `"100m"` | CPU request |
| `deployments.<service>.resources.requests.memory` | `"200Mi"` | Memory request |
| `deployments.<service>.resources.limits.cpu` | `"1000m"` | CPU limit |
| `deployments.<service>.resources.limits.memory` | `"2048Mi"` | Memory limit |

### Ingress Configuration

| Parameter | Default | Description |
|-----------|---------|-------------|
| `deployments.<service>.ingress.enabled` | `true` | Enable ingress for the service |
| `deployments.<service>.ingress.className` | `"nginx"` | Ingress class name |
| `deployments.<service>.ingress.subdomain` | Service-specific | Subdomain for the service |
| `deployments.<service>.ingress.path` | `"/"` | Ingress path |
| `deployments.<service>.ingress.pathType` | `"Prefix"` | Path type |
| `deployments.<service>.ingress.annotations` | `{}` | Ingress annotations |

### Environment Variables

| Parameter | Default | Description |
|-----------|---------|-------------|
| `deployments.<service>.env` | Service-specific | Service environment variables |
| `deployments.<service>.extraEnv` | Service-specific | Additional environment variables |
| `deployments.<service>.sealedSecrets` | `{}` | Sealed secrets (use envsubst for substitution) |
| `sharedEnv` | See values.yaml | Shared environment variables for all services |

### Database Configuration

| Parameter | Default | Description |
|-----------|---------|-------------|
| `postgresql.enabled` | `true` | Enable in-cluster PostgreSQL |
| `postgresql.auth.postgresPassword` | `"postgres"` | PostgreSQL password |
| `postgresql.auth.database` | `"postgres"` | Database name |
| `postgresql.primary.persistence.enabled` | `true` | Enable persistent storage |
| `postgresql.primary.persistence.size` | `"8Gi"` | Storage size |
| `externalDatabase.host` | `""` | External database host |
| `externalDatabase.port` | `5432` | External database port |
| `externalDatabase.database` | `"postgres"` | External database name |
| `externalDatabase.username` | `"postgres"` | External database username |
| `externalDatabase.password` | `""` | External database password |

### Service-Specific Defaults

#### App Service
- **Subdomain**: `webrix-app`
- **Environment**: `PORT`, `ORG`, `ON_PREM`, `NEXTAUTH_URL`, `NEXT_PUBLIC_CONNECT_URL`

#### Connect Service  
- **Subdomain**: `webrix-connect`
- **Environment**: `PORT`, `ORG`, `ON_PREM`, `DEBUG`, `NEXTAUTH_URL`

#### Run Service
- **Subdomain**: `webrix-run`
- **Environment**: `PORT`, `ORG`, `LOG_LEVEL`

#### DB Service
- **Subdomain**: `webrix-dbservice`
- **Environment**: `PORT`, `ORG`, `ON_PREM`, `DEBUG_QUERIES`, `POSTGRES_HOST_AUTH_METHOD`, `RATE_LIMIT_MAX`, `RATE_LIMIT_WINDOW`
