FROM archlinux:latest

WORKDIR /tmp/
RUN curl -O https://blackarch.org/strap.sh
RUN chmod +x strap.sh
RUN ./strap.sh

WORKDIR /root/
RUN echo '[multilib]' >> /etc/pacman.conf
RUN echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf

RUN pacman -Syy --noconfirm \
	base \
	base-devel \
	zip \
	unrar \
	sslsplit \
	sqlmap \
	john \
	hydra \
	zsh \
	git \
	wget \
	vim \
	nano \
	gdb \
	python \
	python-pywinrm \
	python-pip \
	python2 \
	python2-pip \
	rpcbind \
	binutils \
	openssl \
	libffi \
	mlocate \
	nmap \
	nikto \
	openssh \
	sshpass \
	samba \
	smbclient \
	openldap \
	metasploit \
	mitmproxy \
	binwalk \
	gnu-netcat \
	evil-winrm \
	padbuster \
	wfuzz \
	dirb \
	gobuster \
	enum4linux \
	stegsolve \
	steghide

RUN wget https://raw.githubusercontent.com/evyatarmeged/stegextract/master/stegextract -O /usr/bin/stegextract \
	&& chmod +x /usr/bin/stegextract

RUN pip install impacket stegcracker shodan BeautifulSoup4 -U --force-reinstall

RUN wget https://raw.githubusercontent.com/samba-team/samba/master/examples/smb.conf.default -O /etc/samba/smb.conf

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

COPY .zshrc /root/
CMD ["/bin/zsh"]