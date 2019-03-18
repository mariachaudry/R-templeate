# R Template Project

## Overview
-------------
* This is the R template that should be used for Continuous Integration/Continuous Deployment (CI/CD).
* To use this template effectively, git clone the project using the method suggested at the top of the bitbucket page.

### Template Structure
-------------------------
The template consists of 3 main parts:

#### template_r_project folder
template_r_project is the key folder that should contain:

* the source code (src folder) which contains the model
* the test code (test folder) which contains the relevant test code for the model
* the sample test code uses the testthat library 

#### research folder
Empty folder used to house all non-application-deployment work (i.e. initial research and analysis files)

#### Jenkinsfile
The Jenkinsfile is used to define the pipeline and is specifically tailored for R.

The template pipeline consists of 5 stages:

* Checkout repository  - initial special step used to checkout the source the Jenkins file is taken from. NOTE: do not change this line of the Jenkinsfile
* Tests - runs unit tests, outputting a report/documentation on successes/failures
* Doc - outputs documentation in html format
* Docker build and push - logs into docker, builds the image and pushes the image to the docker registry, assigning it with a tag and build number
