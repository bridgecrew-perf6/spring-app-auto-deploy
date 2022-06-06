// pipeline {
//     agent {
//         label 'jenkins-runner-1'
//     }

//     environment {
//         dockerhub = credentials('docker-hub-account-credentials-nizar-dev01')
//     }

//     stages {
//         stage('Clone repository') {
//             steps{
//                 checkout scm
//             }
//         }

//         stage('Run Tests') {
//             steps {
//                 sh '/mvnw clean install'
//                 sh '/mvnw test'
//             }
//         }

//         stage('Build image') {
//             app = docker.build("nizardev01/spring-app")
//         }

//         stage('Test image') {
//             app.inside {
//                 sh 'echo "Tests passed"'
//             }
//         }

//         stage('Push image') {
//             docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-account-credentials-nizar-dev01') {
//                 app.push("${env.BUILD_NUMBER}")
//                 app.push("latest")
//             }
//         }
//     }
// }



// pipeline{
//     agent { label 'jenkins-runner-1' }

//     tools {
//         maven 'MAVEN'
//     }

//     environment {
//         dockerhub = credentials('docker-hub-account-credentials-nizar-dev01')
//     }

//     stages {
//         stage('Build Maven') {
//             steps{
//                 checkout scm
//                 sh "./mvnw clean install"
//             }
//         }
//         stage('Run Tests') {
//             steps{
//                 sh "./mvnw test"
//             }
//         }
//         stage('Build Docker Image') {
//             steps {
//                 app = docker.build("nizardev01/spring-app")
//             }
//         }
//         stage('Test image') {
//             steps {
//                 app.inside {
//                     sh 'echo "Tests passed"'
//                 }
//             }
//         }
//         stage('Deploy Docker Image') {
//             steps {
//                 docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-account-credentials-nizar-dev01') {
//                     app.push("${env.BUILD_NUMBER}")
//                     app.push("latest")
//                 }
//             }
//         }
//     }
// }




  
node {
    def app

    stage('Clone repository, build and test') {
        checkout scm
        sh './mvnw clean install'
        sh './mvnw test'
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
