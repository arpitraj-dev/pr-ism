FROM jenkins/jenkins:lts

USER root

# Install Docker and Git
RUN apt-get update && \
    apt-get -y install curl git && \
    curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh get-docker.sh && \
    rm get-docker.sh && \
    usermod -aG docker jenkins

USER jenkins 