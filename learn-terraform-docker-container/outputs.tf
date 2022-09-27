output "container_id" {
  description = "The ID of the container"
  value = docker_container.nginx.id
}

output "image_id" {
  description = "The ID of the image"
  value = docker_image.nginx.id
}
