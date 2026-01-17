{{- define "common.labels" -}}
app.kubernetes.io/name: {{ .Release.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | default "unknown" }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}


{{- define "common.securityContext" -}}
{{- $defaults := dict
  "runAsNonRoot" true
  "runAsUser" 1000
  "runAsGroup" 1000
  "fsGroup" 2000
  "seccompProfile" (dict "type" "RuntimeDefault")
-}}
{{- $ctx := merge $defaults (.Values.securityContext | default dict) -}}
{{- toYaml $ctx -}}
{{- end -}}


{{- define "common.containerSecurityContext" -}}
{{- $defaults := dict
  "allowPrivilegeEscalation" false
  "readOnlyRootFilesystem" true
  "privileged" false
  "capabilities" (dict "drop" (list "ALL"))
-}}
{{- $ctx := merge $defaults (.Values.containerSecurityContext | default dict) -}}
{{- toYaml $ctx -}}
{{- end -}}
