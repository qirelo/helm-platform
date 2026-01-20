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
{{- $user := .Values.common.securityContext | default dict -}}
{{- toYaml (merge $defaults $user) -}}
{{- end -}}


{{- define "common.containerSecurityContext" -}}
{{- $defaults := dict
  "allowPrivilegeEscalation" false
  "readOnlyRootFilesystem" true
  "privileged" false
  "capabilities" (dict "drop" (list "ALL"))
-}}
{{- $user := .Values.common.containerSecurityContext | default dict -}}
{{- toYaml (merge $defaults $user) -}}
{{- end -}}