# Dashboard

- [Dashboard](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/)
- [Creating Bearer Token](https://github.com/kubernetes/dashboard/wiki/Creating-sample-user)

```bash
$ kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml
$ kubectl proxy
$ open http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/overview?namespace=default
```

Getting the authentication token

```
$ kubectl apply -f dashboard-admin-user.yaml
$ kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')
$ open localhost:8001
```

## How to add `SKIP` button to the Dashboard login screen?

Other option to enable `SKIP` button on login page. Add `enable-skip-login` argument to the container.

```yaml
#...
containers:
  - name: kubernetes-dashboard
    image: k8s.gcr.io/kubernetes-dashboard-amd64:v1.10.1
    ports:
      - containerPort: 8443
        protocol: TCP
    args:
      - --auto-generate-certificates
      - --enable-skip-login
#...
```

Delete the previous deployment:

```
kubectl delete -f ./kubernetes-dashboard.yaml
```

Create the new deployment:

```
kubectl create -f ./kubernetes-dashboard.yaml
```
