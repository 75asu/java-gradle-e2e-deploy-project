pipeline {
  agent any 
  environment {
    VERSION = "${env.BUILD_ID}"
  }
    stages{
        stage("Sonarqube Static Code Check"){
            // agent{
            //     docker{
            //         image 'openjdk:11'
            //         args '-v $HOME/.m2:/root/.m2'
            //     }
            // }

            steps{
                script{
                   withSonarQubeEnv('sonar-server') {
                       sh 'chmod +x gradlew'
                       sh './gradlew sonarqube'
                    }
                    timeout(5) {
                        def qg = waitForQualityGate()
                        if (qg.status != 'OK'){
                            error "pipeline aborted due to quality gate failure: ${qg.status}"
                        }
                    }
                }
            }

        }

        stage("Docker Build And Push") {
            steps {
                script {
                    withCredentials([string(credentialsId: '72ee832e-153a-4512-8394-7fa0e0943384', variable: 'nexus-lab-cred')]) {
                        // some block
                        sh '''
                        docker build -t nexus-lab/simplewebapp:${VERSION} .
                        docker login -u admin -p $nexus-lab-cred 139.59.51.93:8083
                        docker push nexus-lab/simplewebapp:${VERSION}
                        docker rmi nexus-lab/simplewebapp:${VERSION}
                        '''
                    }

                }
            }
        }
    }

}