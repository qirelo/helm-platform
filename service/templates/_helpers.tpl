{{- define "service.name" -}}
{{ .Release.Name }}
{{- end -}}


{{- define "service.labels" -}}
{{- include "common.labels" . -}}
{{- with .Values.service.labels }}
{{ toYaml . -}}
{{- end -}}
{{- end -}}


{{- define "service.selector" -}}
{{- if .Values.service.selector }}
{{- toYaml .Values.service.selector -}}
{{- else }}
app.kubernetes.io/name: {{ .Release.Name }}
{{- end -}}
{{- end -}}
