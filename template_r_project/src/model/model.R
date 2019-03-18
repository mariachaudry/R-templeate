# An example model in R for testing the R template

library(tidyverse)
library(modelr)

options(na.action = na.warn)

# Plot of a sample package generated from the modelr package
ggplot(sim1, aes(x,y)) +
  geom_point()

# Generation of linear regression sample data
model_data <- function(param, data) {
  param[1] + data$x * param[2]
}

# outputting the distance
measure_distance <- function(mod, data) {
  diff <- data$y - model_data(mod, data)
  sqrt(mean(diff ^ 2))
}

# Need to log linear regression implementation
print("R linear regression model")
