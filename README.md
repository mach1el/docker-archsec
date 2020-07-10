# Arch pentest docker
![License](https://img.shields.io/github/license/mach1el/docker-archsec?color=red&style=plastic) ![Version](https://img.shields.io/github/v/release/mach1el/docker-archsec?style=plastic) 

This docker image was created to build minial and important tools which needed to pentest and pratice CTF.Based on [Arch linux](https://www.archlinux.org/) and using [BlackArch's](https://blackarch.org/) repo to install the tools.

### Build the image
    git clone https://github.com/mach1el/docker-archsec.git && cd docker-archsec/
    docker image build -t archsec .

### Run the image
    docker run -it --rm archsec
