
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
                  sh 'docker run --name web-image -d -p 80:80 afunderburg/web-image:v1'
              }
        }

        stage('Push Docker Image') {
              steps {
                    withDockerRegistry([url: "", credentialsId: "docker-hub"]) {
                        sh 'docker push afunderburg/web-image:v1'
                    }
               }
         }

     }
}