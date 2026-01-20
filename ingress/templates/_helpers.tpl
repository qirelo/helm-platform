{{- define "ingress.name" -}}
{{ .Release.Name }}
{{- end -}}


{{- define "ingress.labels" -}}
{{- with .Values.ingress.labels }}
{{- toYaml . -}}
{{- end -}}
{{- end -}}
