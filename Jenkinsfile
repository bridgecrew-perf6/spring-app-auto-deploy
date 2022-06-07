 node {
    def app

    stage('Clone repository, build and test') {
        checkout scm
        sh './mvnw clean install'
        sh './mvnw test'
    }

    stage('Build image') {
       app = docker.build("nizardev01/simplilearn-capstone-project")
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

    stage('Deploy Application') {
        withCredentials([sshUserPrivateKey(credentialsId: "ssh-username-key-spring-app-jenkins", keyFileVariable: 'keyfile')]) {
            stage('Deploy Application to the SWARM Cluster') {
                sh "ssh -i ${keyfile} -o StrictHostKeyChecking=no ubuntu@10.0.12.136 'docker service update --image nizardev01/simplilearn-capstone-project:${env.BUILD_NUMBER} sl-spring-app'"
            }
        }
    }
}
