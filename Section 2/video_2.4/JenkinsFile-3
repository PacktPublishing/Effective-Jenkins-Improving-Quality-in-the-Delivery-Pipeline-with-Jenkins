pipeline {
    agent { label 'linux' }
    stages {
        stage ('Checkout') {
            agent { docker 'gradle:4.5-jdk8-alpine' }
            steps {
                git 'https://github.com/effectivejenkins/jenkins_3_database_migration.git'
            }
        }
        stage('Build') {
            agent { docker 'gradle:4.5-jdk8-alpine' }
            steps {
                sh 'gradle clean build'
                junit 'build/test-results/**/TEST-*.xml'
                archiveArtifacts artifacts: 'build/libs/*.jar', fingerprint: true
                stash includes: 'build/libs/*.jar', name: 'package'
            }
        }
        stage('Migration') {
            agent { docker 'gradle:4.5-jdk8-alpine' }
            steps {
                sh 'gradle migrateStaging'
            }
        }
        stage('Deploy') {
            steps {
                unstash 'package'
                sh 'scp build/libs/*.jar jenkins@192.168.50.6:/opt/app/jenkins_3_database_migration.jar'
                sh "ssh jenkins@192.168.50.6 'sudo systemctl restart jenkins_3_database_migration.service'"
            }
        }
    }
}
