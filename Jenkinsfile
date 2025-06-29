pipeline {
    agent any

    tools {
        nodejs 'node'
    }

    environment {
        DOCKER_IMAGE = 'prism:latest'
    }

    stages {
        stage('Install Dependencies') {
            steps {
                checkout scm
                bat 'npm install'
            }
        }


        stage('Docker Build') {
            steps {
                bat 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('K8s Deploy') {
            steps {
                bat 'kubectl apply -f k8s/ --validate=false --insecure-skip-tls-verify'
                bat 'kubectl get pods -n default --insecure-skip-tls-verify'
                bat 'kubectl get services -n default --insecure-skip-tls-verify'
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}