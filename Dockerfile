FROM archlinux:latest

WORKDIR /root/
RUN echo '[multilib]' >> /etc/pacman.conf
RUN echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
RUN pacman -Syu --needed --noconfirm
RUN pacman -S base base-devel --needed --noconfirm

RUN pacman -Sy --noconfirm net-tools zip unrar sslsplit sqlmap john hydra\
 zsh git wget vim nano gdb python python-pip python2 python2-pip\
 binutils openssl libffi python2-paramiko python-paramiko mlocate\
 nmap nikto openssh sshpass openvpn samba smbclient\
 metasploit exploitdb mitmproxy binwalk gnu-netcat

RUN wget https://raw.githubusercontent.com/evyatarmeged/stegextract/master/stegextract -O /usr/bin/stegextract &&\
	chmod +x /usr/bin/stegextract

RUN wget https://raw.githubusercontent.com/AonCyberLabs/PadBuster/master/padBuster.pl -O /usr/bin/padbuster &&\
    chmod +x /usr/bin/padbuster

RUN wget https://gist.githubusercontent.com/t7hm1/406bde2c95e3ac3d1c0dac22d7f90fe6/raw/05883e0d1b5b8e685944d8295e6ba497c38a8324/start_smb.sh -O /usr/bin/startsmb &&\
	chmod +x /usr/bin/startsmb

RUN git clone https://github.com/danielmiessler/SecLists.git /usr/share/seclists

RUN pip install impacket stegcracker shodan -U --force-reinstall
RUN git clone https://github.com/t7hm1/impacket_scripts.git /root/.impacket_scripts &&\ 
chmod +x /root/.impacket_scripts/*

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN chmod 640 /etc/sudoers && echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && chmod 440 /etc/sudoers && useradd -m -p123 -G wheel yay
RUN rm -rf /tmp/yay &&\
	sudo -u yay git clone https://aur.archlinux.org/yay.git /tmp/yay &&\
	cd /tmp/yay &&\
	pacman -Syy &&\
	yes | sudo -u yay makepkg -sci &&\
	cd /root/

RUN sudo -u yay yay -S --overwrite='*' stegsolve steghide perl-image-exiftool masscan dirbuster wfuzz dirb jre11-openjdk --noconfirm

COPY .zshrc /root/
COPY .profile /root/
CMD ["/bin/zsh"]
