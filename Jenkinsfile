def label = "R-pod-${UUID.randomUUID().toString()}"

DOCKER_IMAGE_NAME='rmg-gbi-de-r-template-project'
//ports: [portMapping(containerPort: 8787)]
podTemplate(label: label,
  containers: [
    containerTemplate(name: 'rtemplate', image: 'mariachaudry/rtemplate_v8', ttyEnabled: true),
    containerTemplate(name: 'docker', image: 'docker', command: 'cat', ttyEnabled: true)
  ],
  volumes: [
    hostPathVolume(hostPath: '/var/jenkins_home/docker.sock', mountPath: '/var/jenkins_home/docker.sock')
  ]) {
    node(label){
    
       stage("Checkout Repository"){
        checkout scm
      }
       container('rtemplate'){

        stage("R Unit Tests"){
          echo 'Beginning R unit testing'
            //sleep 500
            sh "Rscript /work/template_r_project/tests/model/run_tests.R"
            //sh "Rscript /home/rstudio/packages/model_package.R"
          echo 'R unit tests complete' 
        }
        
        stage("R Test Report Generation"){
          echo 'Beginning R report generation'
          sh "cp /work/template_r_project/tests/**/*.xml $WORKSPACE"
          //archiveArtifacts artifacts: "template_r_project/tests/**/*.xml", allowEmptyArchive: true
          //junit 'template_r_project/tests/model/*.xml'
          archiveArtifacts artifacts: "*.xml", allowEmptyArchive: true
          junit '*.xml'
          ///home/jenkins/workspace/new_test_template

          echo 'R report generated complete'
        }

        stage("Package R model"){
          echo 'Beginning R packaging'

          sh "Rscript /home/rstudio/packages/model_package.R"

          echo 'R report packaging complete'
         }
         
        stage("Publish R package"){
          echo 'Beginning publishing R package to GitHub'
          
 

        }
     }

       stage('Create Docker images') {
        container('docker') {
        withCredentials([[$class: 'UsernamePasswordMultiBinding',
          credentialsId: 'dockerhub',
          usernameVariable: 'DOCKER_HUB_USER',
          passwordVariable: 'DOCKER_HUB_PASSWORD']]) {
          sh """
            docker login -u ${DOCKER_HUB_USER} -p ${DOCKER_HUB_PASSWORD}
            docker build -t ${DOCKER_IMAGE_NAME}:${BUILD_NUMBER} -f Dockerfile ."

            docker push ${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}"
            """
  	  }
 	 }

       }
      
   
    } 
}
