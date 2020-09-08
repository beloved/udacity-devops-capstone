
pipeline {
    agent any
    stages {
        stage('Lint HTML') {
             steps {
                sh 'tidy -q -e *.html'
             }
        }
        stage('Image Security Scan') {
        	steps {
        		sh "echo 'Checking Security with Aqua MicroScanner'"
        		aquaMicroscanner(imageName: "nginx:alpine", notCompliesCmd: "exit 1", onDisallowed: "fail", outputFormat: "html")
        	}
        }
        stage('Build Docker Image') {
              steps {
                  sh 'docker build -t afunderburg/cloud-devops-capstone .'
              }
        }

        stage('Push Docker Image') {
              steps {
                    withDockerRegistry([url: "", credentialsId: "dockerhub"]) {
                        sh 'docker push afunderburg/cloud-devops-capstone'
                    }
              }
        }
         stage('Deploying to EKS') {
              steps {
                    withAWS(credentials: 'udacity-devops-capstone', region: 'us-east-1') {
                           sh 'aws eks --region us-east-1 update-kubeconfig --name devops-cluster'
                           sh 'kubectl config use-context arn:aws:eks:us-east-1:449105396446:cluster/devops-cluster'
                           sh "kubectl set image deployments/cloud-devops-capstone cloud-devops-capstone=afunderburg/cloud-devops-capstone:latest"
                           sh "kubectl apply -f deploy.yml"
                           sh "kubectl get nodes"
                           sh "kubectl get deployment"
                           sh "kubectl get pod"
                           sh "kubectl get service/cloud-devops-capstone"
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