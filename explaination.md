Install ansible on the teminal

Create a directory for the project mkdir ansible-IP
Disable SSH host keys checking
Create a hosts file with the IP addresses of the client, backend virtual machines on AWS, file is under hosts on terminus.
Provision the servers
roles: This section specifies the roles that will be executed as part of the playbook. Roles are reusable collections of tasks, handlers, and variables that can be applied to different hosts. In this playbook, two roles are specified:

docker-installation: This role is responsible for installing Docker on the target hosts.
docker-containers: This role is responsible for running the Docker containers using the specified images and configuring them as required.
docker-containers: This role is responsible for running the Docker containers using the specified images and configuring them as required. This role also makes use of docker-compose.yml file to load and run the images
Create the virtual servers
Create the TF file that provisions the VMs on AWS and use use debian-cloud/debian-11 as the boot disk,run them on termius
Also create ssh-keys locally and save the public key on the project file on AWS VM to allow access.
Run terraform init, plan then apply to automatically provision the VMs, and starts the ansbile playbook. Once done, the output will be indicated with the IP that you can access the online app.