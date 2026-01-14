{{- define "common.labels" -}}
app.kubernetes.io/name: {{ .Release.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ index .Values.labels "app.kubernetes.io/managed-by" }}
team: {{ .Values.labels.team }}
environment: {{ .Values.labels.environment }}
{{- end }}
