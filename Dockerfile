FROM archlinux:latest

WORKDIR /root/
RUN echo '[multilib]' >> /etc/pacman.conf
RUN echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
RUN pacman -Syu --needed --noconfirm
RUN pacman -S base base-devel --needed --noconfirm
RUN curl -s https://blackarch.org/strap.sh | sed 's|  check_internet|  #check_internet|' | sh
RUN pacman-key --populate blackarch archlinux
RUN pacman -Sy --noconfirm --needed zsh git wget vim nano gdb python python-pip binutils openssl libffi python2-paramiko python-paramiko
RUN pacman -Sy --noconfirm --needed nmap nikto wfuzz dirb openssh sshpass openvpn metasploit exploitdb mitmproxy binwalk seclists
RUN pacman -Sy --noconfirm --needed net-tools zip unrar sslsplit sqlmap john hydra padbuster stegdetect stegsolve steghide perl-image-exiftool masscan xsser dirbuster python-shodan
RUN wget https://raw.githubusercontent.com/evyatarmeged/stegextract/master/stegextract -O /usr/bin/stegextract && chmod +x /usr/bin/stegextract
RUN wget https://gist.githubusercontent.com/t7hm1/406bde2c95e3ac3d1c0dac22d7f90fe6/raw/05883e0d1b5b8e685944d8295e6ba497c38a8324/start_smb.sh -O /usr/bin/startsmb && chmod +x /usr/bin/startsmb
RUN pip install impacket stegcracker -U --force-reinstall
RUN git clone https://github.com/t7hm1/impacket_scripts.git /root/.impacket_scripts && chmod +x /root/.impacket_scripts/*
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
COPY .zshrc /root/
COPY .profile /root/
CMD ["/bin/zsh"]
