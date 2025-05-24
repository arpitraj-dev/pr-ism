pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'prism'
        DOCKER_TAG = "${BUILD_NUMBER}"
    }

    stages {
        stage('Build & Test') {
            agent {
                docker { image 'node:18' }
            }
            steps {
                sh 'npm install'
                sh 'npm run build'
                sh 'npm test'
            }
        }

        stage('Docker Build') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
            }
        }

        stage('Deploy') {
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