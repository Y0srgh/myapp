pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub-id')
        IMAGE_NAME = "YOUR_DOCKERHUB_USERNAME/myapp"
    }
    stages {
        stage('Cloner le dépôt') {
            steps {
                git branch: 'main', url: 'https://github.com/Y0srgh/myapp.git'
            }
        }
        stage('Build Maven') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Construire l\'image Docker') {
            steps {
                sh "docker build -t $IMAGE_NAME:${env.BUILD_NUMBER} ."
            }
        }
        stage('Exécuter les tests') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Publier sur Docker Hub') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub-id', url: '']) {
                    sh "docker push $IMAGE_NAME:${env.BUILD_NUMBER}"
                }
            }
        }
    }
}
