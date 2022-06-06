pipeline {
    agent {
        label 'jenkins-runner-1'
    }

    environment {
        dockerhub = credentials('docker-hub-account-credentials-nizar-dev01')
    }
    stages {
        stage('Clone repository') {
            checkout scm
        }

        stage('Run Tests') {
            steps {
                sh '/mvnw clean install'
                sh '/mvnw test'
            }
        }

        stage('Build image') {
            app = docker.build("nizardev01/spring-app")
        }

        stage('Test image') {
            app.inside {
                sh 'echo "Tests passed"'
            }
        }

        stage('Push image') {
            docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-account-credentials-nizar-dev01') {
                app.push("${env.BUILD_NUMBER}")
                app.push("latest")
            }
        }
    }
}