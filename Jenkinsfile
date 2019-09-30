pipeline {
    agent {
        label 'go'
    }
    stages {
        stage('UnitTest') {
            steps {
                script {
                    if( sh(script: 'docker run --rm -u root -v $(pwd):$(pwd) -w $(pwd) golang:1.11.0 /bin/bash -c "sh $(pwd)/rununittest.sh"', returnStatus: true ) != 0 ){
                       currentBuild.result = 'FAILURE'
                    }
                }
                junit '*.xml'
                script {
                    if( currentBuild.result == 'FAILURE' ) {
                       sh(script: "echo unit test failed, please fix the errors.")
                       sh "exit 1"
                    }
                }
            }
        }
        stage('Build') {
            steps {
                sh './buildapp.sh'
            }
        }
        stage('Deploy') {
            steps {
                sh './deployapp.sh'
            }
        }
    }
}
