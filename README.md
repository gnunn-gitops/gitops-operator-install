### Introduction

This repository for bootstrapping the initial Red Hat gitops-operator into a cluster. The `setup.sh` performs the following steps:

1. Install operator and wait for it to be complete
2. Overwrite the default `openshift-gitops` instance with my preferred configuration.

### Usage

To install the operator, use the command:

```
./setup.sh <cluster-name>
```

Where `cluster-name` is the name of the cluster you want to install. This name must match an overlay in the `openshift-gitops/overlays` folder, you do not specify a name it will use the `default` overlay.

The reason why we need overlay specific cluster configuration is that I prefer to use an SSO instance to manage the argocd authentication and this requires a cluster specific issuer URL, see the `home` overlay for an example.