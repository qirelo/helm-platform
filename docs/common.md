## Common Helm Library

### Description

This chart is a **Helm library chart** that provides reusable, Kubernetes-best-practice templates (Deployment, helpers, security context, probes, etc.).
It is designed to be **generic, non-opinionated, and safe by default**, suitable for open-source usage.

The library does **not deploy resources by itself**. It must be consumed by an application chart via `include`.

### Usage

Include

```yaml
# Append this in application Chart.yaml
dependencies:
  - name: common
    version: 0.2.4
    repository: oci://ghcr.io/qirelo
```

### List of fields

Main supported values (non-exhaustive)

```yaml
common:
  replicaCount: int

  image:
    repository: string (required)
    tag: string (required)
    pullPolicy: string

  serviceAccountName: string | null

  imagePullSecrets:
    - name: string

  ports: []

  resources: {}

  podLabels: {}
  podAnnotations: {}

  nodeSelector: {}
  affinity: {}
  tolerations: []

  securityContext: {}
  containerSecurityContext: {}

  env: []
  envFrom: []

  volumes: []
  volumeMounts: []

  probes:
    liveness: {}
    readiness: {}
    startup: {}

  command: []
  args: []
```
