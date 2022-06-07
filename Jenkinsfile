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

    // stage('Deploy Application') {
        
    // }
}
