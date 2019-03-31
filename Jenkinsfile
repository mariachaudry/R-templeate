def label = "R-pod-${UUID.randomUUID().toString()}"
DOCKER_IMAGE_NAME='rmg-gbi-de-r-template-project'

podTemplate(label: label,
  containers: [
    containerTemplate(name: 'rtemplate', image: 'rtemplate:latest', ttyEnabled: true),
    containerTemplate(name: 'docker', image: 'docker', command: 'cat', ttyEnabled: true)
  ],
  volumes: [
    hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock')
  ]) {
    node(label){

      stage("Checkout Repository"){
        checkout scm
      }

      container('rtemplate'){

        stage("R Unit Tests"){
          echo 'Beginning R unit testing'

          sh "Rscript template_r_project/tests/model/run_tests.R"

          echo 'R unit tests complete'
        }

        stage("R Test Report Generation"){
          echo 'Beginning R report generation'

          archiveArtifacts artifacts: "template_r_project/tests/**/*.xml", allowEmptyArchive: true
          junit 'template_r_project/tests/model/*.xml'

          echo 'R report generated complete'
        }

        stage("R Package model"){
          echo 'Beginning R packaging'

          sh "Rscript /home/rstudio/packages/model_package.R"

          echo 'R report packaging complete'
        }

      }

#      container('docker'){
#        stage("Docker Image Build"){
#
#            echo 'Building and deploying in docker'
#
#            withCredentials([[$class: 'UsernamePasswordMultiBinding',
#                            credentialsId: 'nexus-docker',
#                            usernameVariable: 'DOCKER_USER',
#                            passwordVariable: 'DOCKER_PASSWORD']]) {
#
#              sh "docker login -u ${env.DOCKER_USER} -p ${env.DOCKER_PASSWORD} ${NEXUS_URL}"
#              sh "docker build -t ${DOCKER_IMAGE_NAME}:${BUILD_NUMBER} -f Dockerfile ."
#              sh "docker tag ${DOCKER_IMAGE_NAME}:${BUILD_NUMBER} ${NEXUS_URL}/rmg/gbi/${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}"
#              sh "docker push ${NEXUS_URL}/rmg/gbi/${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}"
#
#              echo 'Docker R image successfully uploaded to registry'
#        }
#      }
#    }

  stage('Create Docker images') {
      container('docker') {
        withCredentials([[$class: 'UsernamePasswordMultiBinding',
          credentialsId: 'Dockerhub',
          usernameVariable: 'DOCKER_HUB_USER',
          passwordVariable: 'DOCKER_HUB_PASSWORD']]) {
          sh """
            docker login -u ${DOCKER_HUB_USER} -p ${DOCKER_HUB_PASSWORD}
            docker build -t ${DOCKER_IMAGE_NAME}:${BUILD_NUMBER} -f Dockerfile ."
            docker push     rmg/gbi/${DOCKER_IMAGE_NAME}:${BUILD_NUMBER}"
            """
        }
      }
    }
  }
}
