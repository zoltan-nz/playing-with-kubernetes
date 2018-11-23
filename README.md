# Kubernetes Tutorial

The following instruction is mainly relevant for macOS.

## Getting started with Kubernetes

- [Install Docker for Mac with Kubernetes support](https://docs.docker.com/docker-for-mac/install/)

## Readings

- [The Illustrated Children’s Guide to Kubernetes](https://www.cncf.io/the-childrens-illustrated-guide-to-kubernetes/)
- [Concepts](https://kubernetes.io/docs/concepts/)
- [Tutorial](https://kubernetes.io/docs/tutorials/)

## Setup Dashboard

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

Other option to enable `skip` button on login page. Add `enable-skip-login` argument to the container.

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

```bash
$ kubectl cluster-info
$ kubectl get nodes
```

## Deployment

[Source](https://kubernetes.io/docs/tutorials/kubernetes-basics/deploy-intro/)

* Self healing mechanism

### Let's create our simple application in Node.js

* Check `./app` folder.
* Check `./app/Dockerfile`.

```
$ docker build -t zoltannz/kubernetes-app.
$ docker run -p 3000:3000 zoltannz/kubernetes-app
$ docker push zoltannz/kubernetes-app
```

### Deploy

```
$ kubectl get nodes
$ open localhost:8001
$ kubectl run hello-world --image=zoltannz/kubernetes-app --port=3000
```

* searched for a suitable node where an instance of the application could be run (we have only 1 available node)
* scheduled the application to run on that Node
* configured the cluster to reschedule the instance on a new Node when needed
* Check pods on Dashboard.
* Deploy container with GUI.

```
$ kubectl get deployments
```

* Kubernetes run pods in an isolated network, we have to open it up.

```
$ kubectl proxy
$ open http://localhost:8001/api/v1/proxy/namespaces/default/pods/hello-world-542297729-zc06m/
```

Playing with our deployed containers:

```
$ kubectl get
$ kubectl describe
$ kubectl logs
$ kubectl exec
```

Expose to public:

```
$ kubectl get services
$ kubectl expose deployment hello-world --type=NodePort --port 3000
$ minikube service hello-world
```

Running command inside in our Pod container

```
$ kubectl exec -ti hello-world-4149272534-4627k /bin/sh
```