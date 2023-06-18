variable "docker_images"{
  type = list(string)
  description = "these are the images in my environment"
  default = [ 
    "rwambui/yolo-client:1.0.0",
    "rwambui/yolo-backend:1.0.0",
   ]
}
variable "instances" {
  type = list(string)
  default = [
    "ansible-server",
    "ansible-client-one",
    "ansible-client-two",
  ]
}
variable "project_id" {
  type    = string
  default = ""
}

variable "organization_developers" {
  type    = list(string)
  default = [""]
}