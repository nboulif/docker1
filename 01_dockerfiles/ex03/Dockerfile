FROM debian

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y curl openssh-server ca-certificates

EXPOSE 22 443 80 22222

RUN curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
RUN apt-get install gitlab-ce
RUN gitlab-ctl reconfigure


RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-subj "/C=BE/ST=ex/L=ex/O=ex/OU=ex/CN=192.168.99.100/emailAddress=nboulif@student.s19.be" \
		-keyout /etc/gitlab/ssl/selfsigned.key \
		-out /etc/gitlab/ssl/selfsigned.crt

RUN echo "letsencrypt['enable'] = true" >> /etc/gitlab/gitlab.rb
RUN echo "external_url \"https://192.168.99.105\"" >> /etc/gitlab/gitlab.rb
RUN echo "letsencrypt['contact_emails'] = ['foo@email.com']" >> /etc/gitlab/gitlab.rb

RUN echo "nginx['ssl_certificate'] = \"/etc/gitlab/ssl/selfsigned.crt\""  >> /etc/gitlab/gitlab.rb && \
	echo "nginx['ssl_certificate_key'] = \"/etc/gitlab/ssl/selfsigned.key\"" >> /etc/gitlab/gitlab.rb && \
	echo "nginx['redirect_http_to_https'] = true" >> /etc/gitlab/gitlab.rb && \
	echo "nginx['redirect_http_to_https_port'] = 80" >> /etc/gitlab/gitlab.rb && \
	echo "letsencrypt['enable'] = false" >> /etc/gitlab/gitlab.rb && \
	echo "gitlab_rails['gitlab_ssh_host'] = '192.168.99.100'" >> /etc/gitlab/gitlab.rb && \
	echo "gitlab_rails['gitlab_shell_ssh_port'] = 22222" >> /etc/gitlab/gitlab.rb

