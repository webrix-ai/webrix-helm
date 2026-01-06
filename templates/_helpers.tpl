{{/*
Common labels
*/}}
{{- define "webrix.labels" -}}
helm.sh/chart: {{ .Release.Name }}
app.kubernetes.io/name: {{ .Chart.Name }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.global.labels }}
{{ toYaml . }}
{{- end }}


{{/*
Deployment labels for a specific service
*/}}
{{- define "webrix.deploymentLabels" -}}
{{- include "webrix.labels" . | nindent 0 }}
app: {{ .serviceName }}
{{- end }}

{{/*
Service selector labels for a specific service
*/}}
{{- define "webrix.serviceSelectorLabels" -}}
app.kubernetes.io/name: {{ .root.Chart.Name }}
app: {{ .serviceName }} 
{{- end }}

{{/*
Pod labels for a specific service
*/}}
{{- define "webrix.podLabels" -}}
{{- include "webrix.serviceSelectorLabels" (dict "serviceName" .serviceName "root" .root) | nindent 0 }}
{{- with .podLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Pod annotations for a specific service
*/}}
{{- define "webrix.podAnnotations" -}}
{{- with .podAnnotations }}
{{ toYaml . }}
{{- end }}
{{- with .root.Values.global.annotations }}
{{ toYaml . }}
{{- end }}
{{- end }}



{{/*
Return the database URL based on provider
*/}}
{{- define "webrix.databaseUrl" -}}
{{- if eq .Values.global.db_provider "postgresql" -}}
{{- $postgresHost := .Values.postgresql.fullnameOverride | default (printf "%s-postgresql" .Release.Name) -}}
{{- $username := .Values.postgresql.auth.username | default "postgres" -}}
{{- $password := .Values.postgresql.auth.postgresPassword | default "postgres" -}}
{{- $postgresPort := (.Values.postgresql.service.ports.postgresql | default 5432) | int -}}
{{- $postgresDatabase := .Values.postgresql.auth.database | default "postgres" -}}
{{- printf "postgres://%s:%s@%s:%d/%s?sslmode=disable" $username $password $postgresHost $postgresPort $postgresDatabase -}}
{{- else -}}
{{- .Values.externalDatabase.url | default (printf "postgres://%s:%s@%s:%d/%s?sslmode=%s" .Values.externalDatabase.username .Values.externalDatabase.password .Values.externalDatabase.host (.Values.externalDatabase.port | int) .Values.externalDatabase.database .Values.externalDatabase.sslMode) -}}
{{- end -}}
{{- end }}


