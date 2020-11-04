# Playing with Kubernetes

The following instruction is mainly relevant for macOS.

## Getting started with Kubernetes

- [Install Docker for Mac with Kubernetes support](https://docs.docker.com/docker-for-mac/install/)

## Readings

- [The Illustrated Children’s Guide to Kubernetes](https://www.cncf.io/the-childrens-illustrated-guide-to-kubernetes/)
- [Concepts](https://kubernetes.io/docs/concepts/)
- [Tutorial](https://kubernetes.io/docs/tutorials/)
- [Technical details about Docker and Kubernetes for Mac](http://collabnix.com/how-docker-for-mac-works-under-the-hood/)

## Setup WebUI(Dashboard) or Use Octant

- [Dashboard README](./kubernetes-configurations/dashboard/README.md)
- [Octant](https://octant.dev/)

```bash
$ brew install octant
$ octant
```

## Console based manager tool k9s

- Install [k9s](https://k9scli.io/topics/install/)

```
brew install derailed/k9s/k9s
```

## Using Waveworks Scope

- [Scope](https://github.com/weaveworks/scope)

```bash
kubectl apply -f "https://cloud.weave.works/k8s/scope.yaml?k8s-version=$(kubectl version | base64 | tr -d '\n')"
kubectl port-forward -n weave "$(kubectl get -n weave pod --selector=weave-scope-component=app -o jsonpath='{.items..metadata.name}')" 4040
```

Open: http://localhost:4040

## Getting information about your cluster and nodes

```bash
$ kubectl cluster-info
$ kubectl get nodes
```

## Monitoring

- [cAdvisor Kubernetes Daemonset](https://github.com/google/cadvisor/tree/master/deploy/kubernetes)
- [Prometheus](https://prometheus.io/docs/prometheus/latest/installation/)

## Helm

```
brew install helm
helm init --service-account tiller
```

## Deployment

[Source](https://kubernetes.io/docs/tutorials/kubernetes-basics/deploy-intro/)

### Let's create our simple application in Node.js

- Check `./hello-world-app` folder.
- Check `./hello-world-app/Dockerfile`.

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

- searched for a suitable node where an instance of the application could be run (we have only 1 available node)
- scheduled the application to run on that Node
- configured the cluster to reschedule the instance on a new Node when needed
- Check pods on Dashboard.
- Deploy container with GUI.

```bash
$ kubectl get deployments
```

- Kubernetes run pods in an isolated network, we have to open it up.

```
$ kubectl proxy
$ open http://localhost:8001/api/v1/proxy/namespaces/default/pods/hello-world-542297729-zc06m/
```

Playing with our deployed containers:

```bash
$ kubectl get
$ kubectl describe
$ kubectl logs
$ kubectl exec
```

Expose to public:

```bash
$ kubectl get services
$ kubectl expose deployment hello-world --type=NodePort --port 3000
$ minikube service hello-world
```

Running command inside in our Pod container

```
$ kubectl exec -ti hello-world-4149272534-4627k /bin/sh
```

### Namespace

Create namespace for `the-pipeline`:

```
kubectl create namespace the-pipeline
```

Create `the-pipeline` context for the `the-pipeline` namespace.

```
kubectl config set-context the-pipeline --namespace=the-pipeline
```

## Minikube

Prerequisites:

- [Setup loopback alias and `dnsmasq`](https://github.com/zoltan-nz/playing-with-gitlab#setup-dnsmasq-with-loopback-alias).
- [Install `hyperkit` driver](https://github.com/kubernetes/minikube/blob/master/docs/drivers.md#hyperkit-driver).

```shell
brew install hyperkit
brew install docker-machine-driver-hyperkit
```

- [Turn on DHCP client on `dnsmasq`](https://wiki.archlinux.org/index.php/dnsmasq).

Trying to create a new docker-machine but `dnsmasq` dhcp options not picked up.

```shell
docker-machine create --driver hyperkit --engine-opt dns=10.254.254.254
```

Add `listen-address=192.168.64.1` to `dnsmasq.conf`. But it works only if the cluster already started.

```
brew install kubernetes-cli
brew cask install minikube
```

Start minikube with `hyperkit` VM, custom domain name, custom cpu number, and hard drive allocation.

```
minikube start --vm-driver hyperkit --dns-domain "minikube.loc" --cpus 4 --memory 6114 --disk-size 64g
```

## Kubernetes vs Openshift

- [10 most important differences between OpenShift and Kubernetes](https://cloudowski.com/articles/10-differences-between-openshift-and-kubernetes/)

## Create a Registry in Minikube

- <https://blog.hasura.io/sharing-a-local-registry-for-minikube-37c7240d0615/>

## Kubernetes Cheat Sheet

- <https://kubernetes.io/docs/reference/kubectl/cheatsheet/>

## Using MicroK8s with Multipass on macOS

- Useful article: <https://itnext.io/microk8s-on-macos-98f1de3aa63e>
- Article from Ubuntu: <https://ubuntu.com/blog/kubernetes-on-mac-how-to-set-up>
- MicroK8s: <https://microk8s.io/#quick-start>
- Multipass: <https://multipass.run/>

Install Multipass Ubuntu virtual machine runner tool with brew:

```
brew cask install multipass
```

Run a virtual machine. The following command will create a vm with 100G disk, 16G memory and 8 cores CPU.

```
multipass launch -n primary -c 8 -d 100G -m 16G
multipass exec primary -- sudo apt update -y && sudo apt dist-upgrade -y
multipass exec primary -- sudo snap install microk8s --classic
multipass exec primary -- sudo usermod -a -G microk8s multipass
multipass exec primary -- sudo iptables -P FORWARD ACCEPT
```
