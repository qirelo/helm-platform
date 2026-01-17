## Service Helm Library

### Description

This chart is a **Helm library chart** that provides a reusable Kubernetes **Service** template.
It follows Kubernetes best practices and is designed to be **generic, flexible, and safe by default**.

The library does **not deploy resources by itself**.
It must be consumed by an application chart using `include`.

The goal is to standardize Service definitions across applications while keeping full configurability.


### Usage

Include

```yaml
# Append this in application Chart.yaml
dependencies:
  - name: service
    version: 0.1.0
    repository: oci://ghcr.io/qirelo
```

Then include the Service template in your application chart:

```yaml
{{ include "service.service" . }}
```

### List of fields

Main supported values (non-exhaustive)

```yaml
service:
  type: string                # ClusterIP | NodePort | LoadBalancer | ExternalName
  clusterIP: string
  headless: bool

  externalName: string        # Required when type=ExternalName

  labels: {}
  annotations: {}

  selector: {}                # Defaults to app.kubernetes.io/name: <release>

  ports:
    - name: string
      port: int               # Required
      targetPort: int|string
      protocol: TCP|UDP
      nodePort: int
```

### Examples

Minimal Service

```yaml
service:
  ports:
    - port: 80
```

HTTP Service

```yaml
service:
  type: ClusterIP
  ports:
    - name: http
      port: 80
      targetPort: 8080
```

NodePort Service

```yaml
service:
  type: NodePort
  ports:
    - port: 80
      targetPort: 8080
      nodePort: 30080
```

ExternalName Service

```yaml
service:
  type: ExternalName
  externalName: db.example.com
```


<div align="center">
    <br>
    <br>
    <div style="background-color: #ffdc00; height: 3px"></div>
</div>
