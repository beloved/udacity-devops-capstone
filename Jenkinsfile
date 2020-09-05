
pipeline {

     agent any

//      environment {
//              imageName = 'afunderburg/web-image:v1'
//              registryCredentialSet = 'dockerhub'
//              ...
//           }

     stages {

         stage('Lint HTML') {
              steps {
                  sh 'tidy -q -e *.html'
              }
         }
         stage('Build and Push Docker Image') {
               steps {
                   sh 'docker build -t afunderburg/web-image:v1 .'
                   sh 'docker run --name -d -p 80:80 afunderburg/web-image:v1'
                  // sh 'docker push afunderburg/web-image:v1'
               }
           }
         stage('Security Scan') {
              steps {
                 aquaMicroscanner imageName: 'nginx:alpine', notCompliesCmd: 'exit 1', onDisallowed: 'fail'
              }
         }

     }
}