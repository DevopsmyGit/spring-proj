
pipeline{
    agent any
    tools{
        jdk 'jdk11'
        maven 'maven3'
    }


    stages{

        stage('SCM'){
            steps{
                git branch: 'main', changelog: false, poll: false, url: 'https://github.com/DevopsmyGit/spring-proj.git'
            }
        }   

        stage('mvn compile'){
            steps{
                sh "mvn clean compile"

            }
        }

        stage('Static Code Analysis') {
            environment {
                SONAR_URL = "http://localhost:9000"
            }
            steps {
                withCredentials([string(credentialsId: 'sonarqube', variable: 'SONAR_AUTH_TOKEN')]) {
                sh 'mvn sonar:sonar -Dsonar.login=$SONAR_AUTH_TOKEN -Dsonar.host.url=${SONAR_URL}'
                }
            }
        }

        stage{
            steps('mvn build'){
                sh "mvn clean package"
            }
        }
    }

}
