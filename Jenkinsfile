def label = "R-pod-${UUID.randomUUID().toString()}"
    node(label){

      stage("Checkout Repository"){
        checkout scm
      }

      container('rtestthat'){

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

        stage("R Packaging"){
          echo 'Beginning R packaging for the model'

          sh "Rscript template_r_project/packages/model_package.R"

          echo 'R Packaging complete'
        }
      }

  }
