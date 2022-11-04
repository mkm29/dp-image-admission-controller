{{/*
Expand the name of the chart.
*/}}
{{- define "dp-image-admission-controller.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "dp-image-admission-controller.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "dp-image-admission-controller.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "dp-image-admission-controller.labels" -}}
helm.sh/chart: {{ include "dp-image-admission-controller.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "dp-image-admission-controller.serviceAccountName" -}}
  {{ default (include "dp-image-admission-controller.fullname" .) .Values.serviceAccount.name }}
{{- end -}}

{{/*
Generate certificates for webhook
*/}}
{{- define "dp-image-admission-controller.gen-certs" -}}
{{- $fullName := ( include "dp-image-admission-controller.fullname" . ) -}}
{{- $serviceName := ( printf "%s-%s" $fullName "webhook-service" ) -}}
{{- $altNames := list ( printf "%s.%s" $serviceName .Release.Namespace ) ( printf "%s.%s.svc" $serviceName .Release.Namespace ) -}}
{{- $ca := genCA "dp-image-admission-controller-ca" 3650 -}}
{{- $cert := genSignedCert $fullName nil $altNames 3650 $ca -}}
caCert: {{ $ca.Cert | b64enc }}
clientCert: {{ $cert.Cert | b64enc }}
clientKey: {{ $cert.Key | b64enc }}
{{- end -}}