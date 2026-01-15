<div align="center">
    <img src="docs/icon.png" width="70px" heigth="70px" />
</div>

<div align="center">
    <img src="docs/helm.png" width="80px" heigth="80px" />
    <img src="docs/kubernetes.png" width="100px" heigth="100px" />
    <h3>Helm Platform</h3>
</div>

<div align="justify">
A lightweight and opinionated Helm platform foundation for building Kubernetes applications using library charts and composition. This project helps teams standardize Kubernetes deployments while keeping application charts simple, explicit, and maintainable.
</div>

### Who Is This For ?

- Platform / DevOps engineers

- Teams running multiple Kubernetes applications

- Organizations looking for clean Helm architecture

- Anyone tired of giant, unmaintainable Helm charts

### Why This Project ?

- Reduce YAML duplication and enforce consistent Kubernetes standards

- Provide small, focused Helm library charts with clear responsibilities

- Separate platform concerns from application logic

- Favor explicit composition over hidden or implicit behavior

### Repository Structure

```html
helm-platform/
├── common/        # Core library chart (mandatory)
├── service/       # Library chart for Kubernetes Services
├── ingress/       # Library chart for HTTP/HTTPS exposure
└── ...
```

### Usage

This project provides Helm library charts published as OCI artifacts on GitHub Container Registry (GHCR).
They are designed to be consumed as dependencies by application charts.

- Adding a Dependency

To use a library chart (for example common), declare it in your application chart’s Chart.yaml:

```yaml
dependencies:
  - name: common
    version: 0.1.0
    repository: oci://ghcr.io/qirelo
```

Fetching Dependencies

```bash
helm dependency update
```

Using the Library Templates. Library charts expose reusable templates via define / include.


```yaml
{{ include "common.deployment" . }}
```

Rendering and Installing

```bash
helm template my-app .
helm install my-app .
```

### Releasing a chart (Development)

Each chart is released independently using Git tags.

The [release-chart.yaml](.github/workflows/release-chart.yaml)
 workflow automatically packages and publishes a chart to the OCI registry when a release tag is pushed.

From the ```helm-platform``` repository root:

1. Create a release tag

```bash
git tag <chart-name>-v<version>
```

Example

```bash
git tag common-v0.1.0
```

Where:

```html
<chart-name> is the chart directory name (e.g. common)
<version> is the chart version to release (e.g. 0.1.0)
```

2. Push the tag

```bash
git push origin <chart-name>-v<version>  
```

Example

```bash
git push origin common-v0.1.0
```
