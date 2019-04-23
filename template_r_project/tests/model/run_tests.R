library(testthat)
library(xml2)

source("/work/template_r_project/src/model/model.R")

options(testthat.output_file = "/work/template_r_project/tests/model/junit-output.xml")
test_dir("/work/template_r_project/tests/model/", reporter="junit")
