pipeline {
agent any
stages {
stage("Git") {
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
            app = docker.build("reddydinesh/0611")
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
       app.push("${env.BUILD_NUMBER}")
       app.push("latest")
}
}
}
}
}
}


                  
