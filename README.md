# Kubernetes Tutorial

The following instruction is mainly relevant for macOS.

## Getting started with Kubernetes

- [Install Docker for Mac with Kubernetes support](https://docs.docker.com/docker-for-mac/install/)

## What is Kubernetes for?

- Kubernetes helps to run containerized applications where and when you want
- Kubernetes helps containerized apps find the resources and tools they need to work.

## Cluster and Master

[Source](https://kubernetes.io/docs/tutorials/kubernetes-basics/cluster-intro/)

![cluster_master](https://d33wubrfki0l68.cloudfront.net/99d9808dcbf2880a996ed50d308a186b5900cec9/40b94/docs/tutorials/kubernetes-basics/public/images/module_01_cluster.svg)

* **The Master** is responsible for managing the cluster
* **Node** is a worker machine, a docker container

## Setup Dashboard

- [Dashboard](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/)
- [Creating Bearer Token](https://github.com/kubernetes/dashboard/wiki/Creating-sample-user)

```bash
$ kubectl proxy
$ open http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/overview?namespace=default
$ kubectl apply -f dashboard-admin-user.yaml
$ kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')
```

Deploy the Dashboard:

```bash
$ kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml

$ open localhost:8001
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