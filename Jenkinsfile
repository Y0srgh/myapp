pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('docker-hub-id')
        IMAGE_NAME = "y0srgh/myapp"
        IMAGE_TAG = "${env.BUILD_NUMBER}"
        HELM_CHART_PATH = '.'
    }
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Y0srgh/myapp.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:latest .'
            }
        }

        stage('Login to Docker Hub') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                sh 'docker push $IMAGE_NAME:latest'
            }
        }

        stage('Déployer avec Helm') {
            steps { sh 'helm upgrade --install myapp $HELM_CHART_PATH' }
        }

        // stage('Deploy to Kubernetes') {
        //     steps {
        //         sh 'kubectl apply -f deployment.yaml --validate=false'
        //         sh 'kubectl apply -f service.yaml --validate=false'
        //     }
        // }
    }

    post {
        success {
            echo 'Pipeline completed successfully ✅'
        }
        failure {
            echo 'Pipeline failed ❌'
        }
    }
}
