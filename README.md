# Playing with Kubernetes

The following instruction is mainly relevant for macOS.

## Getting started with Kubernetes

- [Install Docker for Mac with Kubernetes support](https://docs.docker.com/docker-for-mac/install/)

## Readings

- [The Illustrated Children’s Guide to Kubernetes](https://www.cncf.io/the-childrens-illustrated-guide-to-kubernetes/)
- [Concepts](https://kubernetes.io/docs/concepts/)
- [Tutorial](https://kubernetes.io/docs/tutorials/)

## Setup Dashboard

[Dashboard README](./kubernetes-configurations/dashboard/README.md)

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

- Check `./app` folder.
- Check `./app/Dockerfile`.

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

```
$ kubectl get deployments
```

- Kubernetes run pods in an isolated network, we have to open it up.

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

### Namespace

Create namespace for `the-pipeline`:

```
kubectl create namespace the-pipeline
```

Create `the-pipeline` context for the `the-pipeline` namespace.

```
kubectl config set-context the-pipeline --namespace=the-pipeline
```
