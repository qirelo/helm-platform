{{- define "common.securityContext" -}}
{{- $defaults := dict
  "runAsNonRoot" true
  "runAsUser" 1000
  "runAsGroup" 1000
  "fsGroup" 2000
  "seccompProfile" (dict "type" "RuntimeDefault")
-}}
{{- $user := .Values.common.securityContext | default dict -}}
{{- toYaml (merge $defaults $user) -}}
{{- end -}}
