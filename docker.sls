install_docker_packages:
pkg.installed:
- pkgs:
- apt-transport-https
- ca-certificates
- curl
- gnupg-agent
- software-properties-common

add_docker_key:
cmd.run:
- name: curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
- cwd: /

download_docker:
cmd.run:
- name: add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
- cwd: /

install_docker:
pkg.installed:
- pkgs:
- docker-ce
- docker-ce-cli
- containerd.io
