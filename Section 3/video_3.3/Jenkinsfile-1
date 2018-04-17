pipeline {
  agent { docker 'gradle:4.5-jdk8-alpine' }
  stages {
    stage('Build') {
      steps {
        sh 'gradle clean build'
          junit 'build/test-results/**/TEST-*.xml'
        }
    }
    stage('deploy to staging') {
      steps {
        echo "deploying to staging"
      }
    }
    stage('deploy to production') {
      steps {
        echo "deploying to production"
      }
    }
  }
}
