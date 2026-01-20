{{- define "service.service" -}}
{{- with .Values.service }}
apiVersion: v1
kind: Service
metadata:
  name: {{ include "service.name" $ }}
  labels:
    {{- include "service.labels" $ | nindent 4 }}
  {{- with .annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}

spec:
  type: {{ .type | default "ClusterIP" }}

  {{- if .headless }}
  clusterIP: None
  {{- else if .clusterIP }}
  clusterIP: {{ .clusterIP }}
  {{- end }}

  {{- if eq (.type | default "ClusterIP") "ExternalName" }}
  externalName: {{ required "service.externalName is required for ExternalName services" .externalName }}
  {{- else }}
  selector:
    {{- if .selector }}
    {{- toYaml .selector | nindent 4 }}
    {{- else }}
    {{- include "common.selectorLabels" $ | nindent 4 }}
    {{- end }}
  {{- end }}

  {{- if not .ports }}
  {{- fail "service.ports must be defined when service is enabled" }}
  {{- end }}

  ports:
    {{- range .ports }}
    - port: {{ .port }}
      {{- with .name }}
      name: {{ . }}
      {{- end }}
      {{- with .targetPort }}
      targetPort: {{ . }}
      {{- end }}
      protocol: {{ .protocol | default "TCP" }}
      {{- with .nodePort }}
      nodePort: {{ . }}
      {{- end }}
    {{- end }}
{{- end }}
{{- end }}
