pipeline {
agent any
stages {
stage("scm") {
steps {git 'https://github.com/reddydinesh050697/jacksparrow.git'}
}
stage("Build") {
steps {
        sh 'mvn clean'
        sh 'mvn install' }
}
stage("docker image build") {
   when {
       branch 'dev'
        }
steps {
       script {
            app = docker.build("reddydinesh/hi")
            app.inside {
                sh 'echo $(curl localhost:8080)'
}
}
}
}
stage("Push Docker Image") {
  when {
    branch 'dev'
       }
steps {
  script {
    docker.withRegistry('https://registry.hub.docker.com', 'docker') {
       app.push("latest")
}
}
}
}
       stage('DeployToProduction') {
            when {
                branch 'dev'
            }
            steps {
                input 'Deploy to Production?'
                milestone(1)
                withCredentials([usernamePassword(credentialsId: 'web', usernameVariable: 'USERNAME', passwordVariable: 'USERPASS')]) {
                    script {
                        sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod_ip \"docker pull reddydinesh/hi:${env.BUILD_NUMBER}\""
                        try {
                            sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod_ip \"docker stop Hippo\""
                            sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod_ip \"docker rm Hippo\""
                        } catch (err) {
                            echo: 'caught error: $err'
                        }
                        sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod_ip \"docker run --restart always --name Hippo -p 8080:8080 -d reddydinesh/hi:${env.BUILD_NUMBER}\""
                    }
                }
            }
        }
    }
} 




                  
