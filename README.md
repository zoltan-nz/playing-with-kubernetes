# kubernetes

* https://kubernetes.io/docs/tasks/tools/install-minikube/
* https://kubernetes.io/docs/getting-started-guides/minikube/


### Installation steps

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

Start minikube cluster:

```bash
$ minikube start --vm-driver=xhyve
$ minikube dashboard
$ kubectl cluster-info
```

