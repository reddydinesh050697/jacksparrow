pipeline {
agent any
stages {
stage ("SCM"){
steps {git 'https://github.com/reddydinesh050697/jacksparrow.git'}
}
stage ("Build"){
steps {
		sh 'mvn clean'
		sh 'mvn install' }
}
stage ("Docker Image build") {
  when {
     branch 'master'
       }
steps {
	script {
	  app = docker.build("reddydinesh/0609")
          app.inside {
              sh 'echo $(curl localhost:8080)'
}
}
}
}
stage("Push Docker Image") {
  when {
    branch 'master'
       }
steps {
  script {
    docker.withRegistry('https://registry.hub.docker.com', 'docker') {
       app.push("${env.BUILD_NUMBER}")
       app.push("latest")
}
}
}
}
	stage('DeployToProduction') {
            when {
                branch 'master'
            }
            steps {
                input 'Deploy to Production?'
                milestone(1)
                withCredentials([usernamePassword(credentialsId: 'web', usernameVariable: 'USERNAME', passwordVariable: 'USERPASS')]) {
                    script {
                        sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod_ip \"docker pull reddydinesh/0609:${env.BUILD_NUMBER}\""
                        try {
                            sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod_ip \"docker stop Hippo\""
                            sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod_ip \"docker rm Hippo\""
                        } catch (err) {
                            echo: 'caught error: $err'
                        }
                        sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod_ip \"docker run --restart always --name Hippo -p 8080:8080 -d reddydinesh/0609:${env.BUILD_NUMBER}\""
                    }
                }
            }
        }
    }
}                 
