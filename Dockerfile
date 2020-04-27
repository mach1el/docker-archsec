FROM archlinux:latest

WORKDIR /root/
RUN echo '[multilib]' >> /etc/pacman.conf
RUN echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf
RUN pacman -Syu --needed --noconfirm
RUN pacman -S base base-devel --needed --noconfirm

RUN pacman -Sy --noconfirm net-tools zip unrar sslsplit sqlmap john hydra\
 zsh git wget vim nano gdb python python-pip python2 python2-pip rpcbind\
 binutils openssl libffi python2-paramiko python-paramiko mlocate\
 nmap nikto openssh sshpass openvpn samba smbclient openldap\
 metasploit exploitdb mitmproxy binwalk gnu-netcat

RUN wget https://raw.githubusercontent.com/samba-team/samba/master/examples/smb.conf.default -O /etc/samba/smb.conf

RUN wget https://raw.githubusercontent.com/evyatarmeged/stegextract/master/stegextract -O /usr/bin/stegextract &&\
	chmod +x /usr/bin/stegextract

RUN wget https://raw.githubusercontent.com/AonCyberLabs/PadBuster/master/padBuster.pl -O /usr/bin/padbuster &&\
    chmod +x /usr/bin/padbuster

RUN git clone https://github.com/danielmiessler/SecLists.git /usr/share/seclists

RUN gem install evil-winrm
RUN pip install impacket stegcracker shodan BeautifulSoup4 -U --force-reinstall

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN chmod 640 /etc/sudoers && echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && chmod 440 /etc/sudoers && useradd -m -pyay -G wheel yay
RUN rm -rf /tmp/yay &&\
	sudo -u yay git clone https://aur.archlinux.org/yay.git /tmp/yay &&\
	cd /tmp/yay &&\
	pacman -Syy &&\
	yes | sudo -u yay makepkg -sci &&\
	cd /root/

RUN sudo -u yay yay -S --overwrite='*' smbmap enum4linux stegsolve steghide perl-image-exiftool masscan dirbuster dirb jre11-openjdk --noconfirm
RUN go get github.com/OJ/gobuster

COPY .zshrc /root/
ENV PATH="${PATH}:/root/.gem/ruby/2.7.0/bin:/root/go/bin"
CMD ["/bin/zsh"]
