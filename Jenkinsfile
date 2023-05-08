pipeline {
  agent any 
    stages{
        stage("sonarqube static code check"){
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
                       sh './gradlew sonarqube --debug output'
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
    }

}