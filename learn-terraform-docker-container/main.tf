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
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = var.container_name
  ports {
    internal = 80
    external = 8080
  }
}
