# Implementation notes

## Building The Pipeline

Prerequisite:

- Working Kubernetes Cluster
- Helm is installed

[Cheat sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)

### Install Concourse with Helm

- [Helm/Concourse documentation](https://github.com/helm/charts/tree/master/stable/concourse)

```
helm install stable/concourse
```

It is better to use a dedicated name (`namespace`).

```
helm install --name the-pipeline stable/concourse
```

Delete the previous install

```
helm list
helm delete {namespace}
```
