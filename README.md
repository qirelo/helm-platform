<div align="center">
    <img src="docs/helm.png" width="80px" heigth="80px" />
    <p>Helm Platform</p>
</div>

<div align="justify">
A lightweight and opinionated Helm platform foundation for building Kubernetes applications using library charts and composition.

This project helps teams standardize Kubernetes deployments while keeping application charts simple, explicit, and maintainable.
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
└── apps/          # Application charts (examples or real apps)
```

### Application Charts

- live under ```apps/```

- are deployable ```(type: application)```

- compose library charts explicitly

Example:

```yaml
{{ include "common.deployment" . }}
{{ include "service.service" . }}
{{ include "ingress.ingress" . }}
```

Nothing is generated unless it is explicitly included.

### Getting Started

```bash
helm dependency update apps/my-app
helm template apps/my-app
```
