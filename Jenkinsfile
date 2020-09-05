
pipeline {
    environment {
        registry = "afunderburg/web-image"
        registryCredential = 'dockerhub'
        dockerImage = ''
      }
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
                  //sh 'docker run --name temp-web-image -d -p 80:80 afunderburg/web-image:v1'
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
                             sh "docker system prune"
                       }
                 }

     }
}