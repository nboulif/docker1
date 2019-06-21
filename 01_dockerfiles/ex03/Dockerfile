FROM debian
WORKDIR /

# RUN echo 'root:qazwsxedc' | chpasswd

RUN apt-get update
RUN apt-get install -y wget openssh-server ca-certificates postfix
# RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN wget https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh \
	&& chmod 777 script.deb.sh && ./script.deb.sh
RUN apt-get install -y gitlab-ce

RUN apt update && apt install -y tzdata
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /etc/gitlab/ssl
RUN chmod 700 /etc/gitlab/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
	-subj /C=BE/ST=bxl/L=bxl/O=bxl/OU=rs1/CN=192.168.99.103/emailAddress=nboulif@student.s19.be \
	-keyout /etc/gitlab/ssl/selfsigned.key -out /etc/gitlab/ssl/selfsigned.crt

RUN echo "external_url \"https://192.168.99.103\"
nginx['redirect_http_to_https'] = true
nginx['ssl_certificate'] = \"/etc/gitlab/ssl/selfsigned.crt\"
nginx['ssl_certificate_key'] = \"/etc/gitlab/ssl/selfsigned.key\"
gitlab_rails['gitlab_shell_ssh_port'] = 2222" >> /etc/gitlab/gitlab.rb

ENTRYPOINT service ssh restart && (/opt/gitlab/embedded/bin/runsvdir-start &) 
	&& gitlab-ctl reconfigure && gitlab-ctl tail

# docker build -t ex03 .
# docker run --name ex03 -it -p 80:80 -p 2222:22 -p 443:443 --privileged ex03

# ssh-keygen -o -f ~/.ssh/id_rsa
# pbcopy < ~/.ssh/id_rsa.pub
# paste result on website

# When git clone or git push with HTTPS add 'GIT_SSL_NO_VERIFY=true' at the begining of each commands like '$ GIT_SSL_NO_VERIFY=true git push'
# When git push with https://* in directory do '$ git config http.emptyAuth true' to avoid HTTP error if you get one
