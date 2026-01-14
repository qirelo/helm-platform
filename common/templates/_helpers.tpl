{{- define "common.labels" -}}
app.kubernetes.io/name: {{ .Release.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ index .Values.common.labels "app.kubernetes.io/managed-by" }}
team: {{ .Values.common.labels.team }}
environment: {{ .Values.common.labels.environment }}
{{- end }}
