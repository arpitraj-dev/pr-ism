# PRism

## Prerequisites

-   Node.js & npm
-   Docker
-   Minikube
-   kubectl

## Quick Start

1. Install dependencies:

```bash
npm install
```

2. Build project:

```bash
npm run build
```

3. Start Kubernetes:

```bash
minikube start
minikube service prism --url
```

## Jenkins Integration

1. Start Jenkins locally:

```bash
docker-compose -f docker-compose.jenkins.yml up -d
```

2. Access Jenkins:

-   Open http://localhost:8080
-   Use initial admin password from:

```bash
docker-compose -f docker-compose.jenkins.yml exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

3. Install required plugins:

-   Docker Pipeline
-   Kubernetes CLI
-   NodeJS

4. Create pipeline:

-   Select "Pipeline from SCM"
-   Add your repository URL
-   Set branch to \*/main
-   Save and run

5. Stop Jenkins:

```bash
docker-compose -f docker-compose.jenkins.yml down
```

## Development

Run tests:

```bash
npm test
```

Build Docker image:

```bash
docker build -t prism:latest .
```

Deploy to K8s:

```bash
kubectl apply -f k8s/
```

## Jenkins

PWD - d32935ec7fd7491db9e1bd14b5ccbbdb
