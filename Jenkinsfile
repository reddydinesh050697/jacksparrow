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
            app = docker.build("reddydinesh050697/0609")
            app.inside {
                 sh 'echo $(curl localhost:8080)'
}
}
}
}
}
}



                  
