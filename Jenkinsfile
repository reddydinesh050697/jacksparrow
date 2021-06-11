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
	  app = docker.build("reddydinesh050697/0609")
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
       app.push("$(env.BUILD_NUMBER}")
       app.push("latest")
}
}
}
}
}
}                  
