{{- define "common.selectorLabels" -}}
app.kubernetes.io/name: {{ .Release.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}


{{- define "common.labels" -}}
{{- include "common.selectorLabels" . }}
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
{{- $common := $.Values.common | default dict -}}
{{- if hasKey $common "securityContext" -}}
{{- toYaml $common.securityContext -}}
{{- else -}}
{{- toYaml $defaults -}}
{{- end -}}
{{- end -}}


{{- define "common.containerSecurityContext" -}}
{{- $defaults := dict
  "allowPrivilegeEscalation" false
  "readOnlyRootFilesystem" true
  "privileged" false
  "capabilities" (dict "drop" (list "ALL"))
-}}
{{- $common := $.Values.common | default dict -}}
{{- if hasKey $common "containerSecurityContext" -}}
{{- toYaml $common.containerSecurityContext -}}
{{- else -}}
{{- toYaml $defaults -}}
{{- end -}}
{{- end -}}
