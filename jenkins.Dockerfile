FROM jenkins/jenkins:lts

USER root

# Install Docker and Git
RUN apt-get update && \
    apt-get -y install curl git && \
    curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh get-docker.sh && \
    rm get-docker.sh && \
    usermod -aG docker jenkins

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin/

# Create script to fix kubectl config paths and server URL
RUN echo '#!/bin/bash\n\
if [ -f /root/.kube/config ]; then\n\
    sed -i "s|/Users/[^/]*/\.minikube|/root/.minikube|g" /root/.kube/config\n\
    sed -i "s|https://127\.0\.0\.1:|https://host.docker.internal:|g" /root/.kube/config\n\
    sed -i "s|https://localhost:|https://host.docker.internal:|g" /root/.kube/config\n\
fi\n\
exec "$@"' > /usr/local/bin/fix-kube-config.sh && \
    chmod +x /usr/local/bin/fix-kube-config.sh

ENTRYPOINT ["/usr/local/bin/fix-kube-config.sh"]
CMD ["/usr/bin/tini", "--", "/usr/local/bin/jenkins.sh"]

USER jenkins 