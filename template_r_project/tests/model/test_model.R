# Testfile of the R model
library(testthat)
library(modelr)

context("Linear regression model")

test_that("data generation", {
  generated_data <- model_data(c(3, 2), sim1)
  expected_data <- c(5, 5, 5, 7, 7, 7, 9, 9, 9, 11, 11, 11, 13, 13, 13, 15,
    15, 15, 17, 17, 17, 19, 19, 19, 21, 21, 21, 23, 23, 23)
  expect_equal(generated_data, expected_data)
})

test_that("Measuring distance", {
  measured_distance <- measure_distance(c(8, 2), sim1)
  expect_equal(round(measured_distance, digits=2), 4.1)
})
