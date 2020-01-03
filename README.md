# Arch pentest docker
This docker image was created to build minial and important tools which needed to pentest and pratice CTF.Based on [Arch linux](https://www.archlinux.org/) and using [BlackArch's](https://blackarch.org/) repo to install the tools.

### Build the image
    git clone https://github.com/t7hm1/arch-pentest-docker.git && cd arch-pentest-docker/
    docker image build -t archsec .

### Run the image
    docker run -it --rm archsec
