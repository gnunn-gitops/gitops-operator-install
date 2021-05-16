### Introduction

This repository for bootstrapping the initial Red Hat gitops-operator into a cluster. The `setup.sh` performs the following steps:

1. Install operator and wait for it to be complete
2. Overwrite the default `openshift-gitops` instance with my preferred configuration.

### Usage

To install the operator, login as a user with `cluster-admin` privileges and use the command:

```
./setup.sh <overlay>
```

Where `overlay` is the name of the cluster you want to install. This name must match an overlay in the `openshift-gitops/overlays` folder, you do not specify a name it will use the `dex` overlay.

The reason why we need overlay for specific configurations is to have options for both RH-SSO and Dex for integrated authentication. Using an SSO instance to manage the argocd authentication requires a cluster specific issuer URL, see the `home` overlay for an example.