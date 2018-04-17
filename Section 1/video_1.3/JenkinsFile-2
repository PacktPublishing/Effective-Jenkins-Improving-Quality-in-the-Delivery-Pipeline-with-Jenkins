pipeline {
    agent { docker 'gradle:4.5-jdk8-alpine' }
    stages {
        stage ('Checkout') {
          steps {
            git 'https://github.com/effectivejenkins/gs-serving-web-content.git'
          }
        }
        stage('Build') {
            steps {
                sh 'gradle clean compileJava'
            }
        }
        stage('Unit-tests') {
            steps {
                sh 'gradle test'
            }
        }
        stage('Integration-tests') {
            steps {
                sh 'gradle integrationTest'
            }
        }
    }
    post {
        always {
            junit 'build/test-results/**/TEST-*.xml'
        }
    }
}
