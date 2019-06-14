# WEB UI (Dashboard)

- [Dashboard](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/)

```bash
$ kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta1/aio/deploy/recommended.yaml
$ kubectl proxy
$ open http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login
```

Getting the authentication token

- [Creating Bearer Token](https://github.com/kubernetes/dashboard/wiki/Creating-sample-user)

```
$ kubectl apply -f dashboard-admin-user.yaml
$ kubectl describe secret --namespace kube-system $(kubectl get secret --namespace kube-system | grep admin-user | awk '{print $1}')
$ open localhost:8001
```

The user name of admin is unique.
Generate a super admin namespace:

```bash
kubectl config set-context admin-user-token-mzpqn --namespace=kube-system  --cluster docker-desktop --user admin-user-token-mzpqn
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
