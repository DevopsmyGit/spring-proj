pipeline {
    agent any
    tools{
        maven 'maven3'
    }
        
    stages {
        
        stage('SCM') {
            steps {
                git branch: 'main', url: 'https://github.com/DevopsmyGit/spring-proj.git'
            }
        }
        
        stage('Maven Compile'){
            steps{
                sh 'mvn compile'
            }
        }
        
        stage('OWASP'){
            steps {
                dependencyCheck additionalArguments: '--scan ./ ', odcInstallation: 'DC'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }
        
        stage('Maven Build'){
            steps{
                sh "mvn clean package"
            }
        }
        
         stage('Static Code Analysis') {
            environment {
                SONAR_URL = "http://127.0.0.1:9000"
            }
            steps {
                withCredentials([string(credentialsId: 'sonarqube', variable: 'SONAR_AUTH_TOKEN')]) {
                sh 'mvn sonar:sonar -Dsonar.login=$SONAR_AUTH_TOKEN -Dsonar.host.url=${SONAR_URL}'
                }
            }
        }
        
        stage('Docker Build'){
            steps{
                script{
                    sh 'docker build -t spring-k8s .'
                }
            }
        }
        
        stage('Push to docker hub'){
            steps{
                sh 'docker tag spring-k8s devopsmydockerhub/spring-proj:spring-k8s'
                sh 'docker push devopsmydockerhub/spring-proj:spring-k8s'
            }
        }
    }
}
