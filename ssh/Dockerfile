FROM azi03/java-server:1.8

COPY sshd.start /etc/local.d/sshd.start

ENV ROOT_PASSWORD=admin

RUN apk update && \
	apk add --no-cache openssh-server openssh-client && \
	sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
	ssh-keygen -t dsa -P "" -f /etc/ssh/ssh_host_dsa_key && \
    ssh-keygen -t rsa -P "" -f /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -t ecdsa -P "" -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -t ed25519 -P "" -f /etc/ssh/ssh_host_ed25519_key && \
    echo "root:${ROOT_PASSWORD}" | chpasswd && \
	chmod +x /etc/local.d/sshd.start
	
ENTRYPOINT ["/etc/local.d/sshd.start"]