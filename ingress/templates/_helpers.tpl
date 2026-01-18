{{- define "ingress.name" -}}
{{ .Release.Name }}
{{- end -}}


{{- define "ingress.labels" -}}
{{- include "common.labels" . -}}
{{- with .Values.ingress.labels }}
{{- toYaml . }}
{{- end -}}
{{- end -}}
