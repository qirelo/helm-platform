{{- define "common.deployment" -}}
{{- $common := .Values.common | default dict -}}

apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}
  labels:
    {{- include "common.labels" . | nindent 4 }}

spec:
  replicas: {{ $common.replicaCount | default 1 }}

  selector:
    matchLabels:
      app.kubernetes.io/name: {{ .Release.Name }}

  template:
    metadata:
      labels:
        {{- include "common.labels" . | nindent 8 }}
        {{- with $common.podLabels }}
        {{- toYaml . | nindent 8 }}
        {{- end }}
      {{- with $common.podAnnotations }}
      annotations:
        {{- toYaml . | nindent 8 }}
      {{- end }}

    spec:
      {{- with $common.serviceAccountName }}
      serviceAccountName: {{ . }}
      {{- end }}

      {{- with $common.imagePullSecrets }}
      imagePullSecrets:
        {{- toYaml . | nindent 8 }}
      {{- end }}

      securityContext:
        {{- include "common.securityContext" . | nindent 8 }}

      {{- with $common.nodeSelector }}
      nodeSelector:
        {{- toYaml . | nindent 8 }}
      {{- end }}

      {{- with $common.affinity }}
      affinity:
        {{- toYaml . | nindent 8 }}
      {{- end }}

      {{- with $common.tolerations }}
      tolerations:
        {{- toYaml . | nindent 8 }}
      {{- end }}

      {{- with $common.volumes }}
      volumes:
        {{- toYaml . | nindent 8 }}
      {{- end }}

      containers:
        - name: {{ .Release.Name }}
          image: "{{ required "common.image.repository is required" $common.image.repository }}:{{ required "common.image.tag is required" $common.image.tag }}"
          imagePullPolicy: {{ $common.image.pullPolicy | default "IfNotPresent" }}

          {{- with $common.command }}
          command:
            {{- toYaml . | nindent 12 }}
          {{- end }}

          {{- with $common.args }}
          args:
            {{- toYaml . | nindent 12 }}
          {{- end }}

          {{- with $common.ports }}
          ports:
            {{- toYaml . | nindent 12 }}
          {{- end }}

          securityContext:
            {{- include "common.containerSecurityContext" . | nindent 12 }}

          {{- with $common.envFrom }}
          envFrom:
            {{- toYaml . | nindent 12 }}
          {{- end }}

          {{- with $common.env }}
          env:
            {{- toYaml . | nindent 12 }}
          {{- end }}

          {{- with $common.probes }}
            {{- with .liveness }}
          livenessProbe:
            {{- toYaml . | nindent 12 }}
            {{- end }}

            {{- with .readiness }}
          readinessProbe:
            {{- toYaml . | nindent 12 }}
            {{- end }}

            {{- with .startup }}
          startupProbe:
            {{- toYaml . | nindent 12 }}
            {{- end }}
          {{- end }}

          {{- with $common.volumeMounts }}
          volumeMounts:
            {{- toYaml . | nindent 12 }}
          {{- end }}

          {{- with $common.resources }}
          resources:
            {{- toYaml . | nindent 12 }}
          {{- end }}
{{- end }}
