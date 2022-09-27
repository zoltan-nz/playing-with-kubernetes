# Learn Terraform

## Basics

Tutorial: https://developer.hashicorp.com/terraform/tutorials/docker-get-started/install-cli

Prerequisites:

- Docker Desktop

```bash
brew install terraform
```

Steps:

1. Create a directory for the project

```bash
mkdir learn-terraform-docker-container
cd learn-terraform-docker-container
```

2. Create a file named `main.tf` with the following content:

```hcl
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">=2.22.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}
```
- Provider: https://registry.terraform.io/namespaces/kreuzwerker

Run: `terraform init`

3. Add a resource to the `main.tf` file:

```hcl
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">=2.22.0"
    }
  }
}

provider "docker" {
  #  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "nginx" {
  name = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "nginx"
  ports {
    internal = 80
    external = 8080
  }
}
```

Notes:
- `docker_image.nginx.latest` is deprecated
- `image_id` is the ID of the image that was created in the previous step

```
terraform apply
terraform destroy
```

```
terraform fmt
terraform validate
terraform show
terraform state list
```

4. Variables

`variables.tf`

```hcl
variable "container_name" {
  description = "The name of the container"
  type = string
  default = "nginx"
}
```

Using variable in `main.tf`:

```hcl
  name = var.container_name
```

Changing variable from command line:

```bash
terraform apply -var container_name=nginx2
```

5. Outputs

`outputs.tf`

```hcl
output "container_id" {
  description = "The ID of the container"
  value = docker_container.nginx.id
}

output "image_id" {
  description = "The ID of the image"
  value = docker_image.nginx.id
}
```

```bash
terraform apply
terraform output
```

## Manage Kubernetes

Have to install `kind`.

```bash
brew install kind
```

```bash
kind create cluster --name learn-terraform
```
