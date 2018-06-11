FROM jenkins

USER root

#ARG DEBIAN_FRONTED=noninteractive
ARG TERM=xterm-256color

RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg2 \
	software-properties-common


RUN  curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

RUN add-apt-repository \
	"deb [arch=amd64] https://download.docker.com/linux/debian \
	$(lsb_release -cs) \
	stable"


RUN apt-get update && apt-get install -y docker-ce

RUN curl -L https://github.com/docker/compose/releases/download/1.20.1/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

RUN chmod +x /usr/local/bin/docker-compose

RUN usermod -aG docker jenkins

# Install daemonize
RUN cd /tmp
RUN git clone https://github.com/bmc/daemonize
RUN cd daemonize && \
	sh configure && \
	make && \
	make install

USER jenkins

