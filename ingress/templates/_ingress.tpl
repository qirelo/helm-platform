{{- define "ingress.ingress" -}}
{{- if .Values.ingress.enabled }}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ include "ingress.name" . }}
  labels:
    {{- include "ingress.labels" . | nindent 4 }}
  {{- with .Values.ingress.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}

spec:
  {{- with .Values.ingress.ingressClassName }}
  ingressClassName: {{ . }}
  {{- end }}

  {{- with .Values.ingress.tls }}
  tls:
    {{- toYaml . | nindent 4 }}
  {{- end }}

  {{- if not .Values.ingress.hosts }}
  {{- fail "ingress.hosts must be defined when ingress is enabled" }}
  {{- end }}

  rules:
    {{- range .Values.ingress.hosts }}
    - host: {{ .host }}
      http:
        paths:
          {{- range .paths }}
          - path: {{ .path | default "/" }}
            pathType: {{ .pathType | default "Prefix" }}
            backend:
              service:
                name: {{ .serviceName | default $.Release.Name }}
                port:
                  number: {{ .servicePort | default 80 }}
          {{- end }}
    {{- end }}
{{- end }}
{{- end }}
