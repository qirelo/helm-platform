## Ingress Helm Library

### Description

This chart is a **Helm library chart** that provides a reusable Kubernetes **Ingress** template.
It is designed to be **controller-agnostic**, flexible, and aligned with Kubernetes best practices.

The library does **not deploy resources by itself**.
It must be consumed by an application chart using `include`.

The goal is to standardize HTTP/HTTPS exposure while keeping full control in application charts.


### Usage

Include

```yaml
# Append this in application Chart.yaml
dependencies:
  - name: ingress
    version: 0.1.0
    repository: oci://ghcr.io/qirelo
```

Then include the template in your application chart:

```yaml
{{ include "ingress.ingress" . }}
```

### List of fields

Main supported values (non-exhaustive)

```yaml
ingress:
  enabled: bool

  ingressClassName: string
  annotations: {}
  labels: {}

  hosts:
    - host: string
      paths:
        - path: string
          pathType: Prefix | Exact | ImplementationSpecific
          serviceName: string
          servicePort: int

  tls:
    - secretName: string
      hosts:
        - string
```

### Examples

Basic HTTP Ingress

```yaml
ingress:
  enabled: true
  hosts:
    - host: my-app.example.com
      paths:
        - path: /
          servicePort: 80
```

Ingress with class and annotations

```yaml
ingress:
  enabled: true
  ingressClassName: nginx
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
  hosts:
    - host: my-app.example.com
      paths:
        - path: /
          pathType: Prefix
          servicePort: 80
```

TLS enabled

```yaml
ingress:
  enabled: true
  hosts:
    - host: my-app.example.com
      paths:
        - path: /
          servicePort: 80
  tls:
    - secretName: my-app-tls
      hosts:
        - my-app.example.com
```