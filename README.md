# kubernetes

* https://kubernetes.io/docs/tasks/tools/install-minikube/
* https://kubernetes.io/docs/getting-started-guides/minikube/


### Prerequisites

Setup Docker and VM support:

```bash
$ brew install docker-machine-driver-xhyve
$ brew info docker-machine-driver-xhyve

This driver requires superuser privileges to access the hypervisor. To
enable, execute
    $ sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
    $ sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
```

Install Kubernetes command line interface:

* https://kubernetes.io/docs/tasks/tools/install-kubectl/

```bash
$ brew install kubectl
$ kubectl version
```

Install minikube:

* https://github.com/kubernetes/minikube/releases


```bash
$ curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.22.2/minikube-darwin-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
$ minikube version
```

Minikube runs a single-node Kubernetes cluster inside a VM on your laptop for users looking to try out Kubernetes or develop with it day-to-day.

* https://github.com/kubernetes/minikube/blob/v0.22.2/README.md

# What is it for?

* Kubernetes helps to run containerized applications where and when you want
* Kubernetes helps containerized apps find the resources and tools they need to work.

## Cluster and Master

[Source](https://kubernetes.io/docs/tutorials/kubernetes-basics/cluster-intro/)

![cluster_master](https://d33wubrfki0l68.cloudfront.net/99d9808dcbf2880a996ed50d308a186b5900cec9/40b94/docs/tutorials/kubernetes-basics/public/images/module_01_cluster.svg)

* **The Master** is responsible for managing the cluster
* **Node** is a worker machine, a docker container

### Creating a cluster

Start minikube cluster:

```bash
$ minikube version
$ minikube start --vm-driver=xhyve
$ minikube dashboard
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
$ minikube dashboard
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