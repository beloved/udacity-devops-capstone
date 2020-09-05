
pipeline {
    agent any
    stages {
        stage('Lint HTML') {
             steps {
                 sh 'tidy -q -e *.html'
             }
        }
        stage('Build Docker Image') {
              steps {
                  sh 'docker build -t afunderburg/web-image:v1 .'
              }
        }

        stage('Push Docker Image') {
              steps {
                    withDockerRegistry([url: "", credentialsId: "dockerhub"]) {
                        sh 'docker push afunderburg/web-image:v1'
                    }
               }
         }
         stage("Remove Docker images") {
                       steps{
                             sh "docker system prune -f "
                       }
                 }

     }
}