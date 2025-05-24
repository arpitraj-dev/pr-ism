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
                sh 'npm install'
            }
        }


        stage('Docker Build') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('K8s Deploy') {
            steps {
                sh 'kubectl apply -f k8s/'
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}