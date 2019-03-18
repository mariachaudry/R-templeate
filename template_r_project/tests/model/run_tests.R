library(testthat)
library(xml2)

source("./template_r_project/src/model/model.R")

options(testthat.output_file = "./template_r_project/tests/model/junit-output.xml")
test_dir("./template_r_project/tests/model/", reporter="junit")
