# Deploy under Kubernetes Namespace

- [Namespace walk-through](https://kubernetes.io/docs/tasks/administer-cluster/namespaces-walkthrough/)

Check we are in the right cluster

```bash
kubectl config view
kubectl config current-context
kubectl config get-contexts
kubectl config use-context docker-desktop
```

Create a new namespace and attach to a context with a user

```bash
$ kubectl create namespace flaskr
$ kubectl config set-context review --namespace=flaskr --cluster docker-desktop --user docker-desktop
```

Deploy your image

```bash
kubectl run snowflake --image=k8s.gcr.io/serve_hostname --replicas=2
```

## Local Kubernetes

Use: `imagePullPolicy: Never`

Source: <https://stackoverflow.com/questions/50739405/docker-for-macedge-kubernetes-reference-local-image>
