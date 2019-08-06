# set up a function to get a vector of 0/1 from a vector of probabilities
sample_bin <- function(p) {
   map_int(p, ~ sample(0:1, 1, prob = c(1 - .x, .x)))
}

model_formula <- function(outcome,predictors) {
   rlang::new_formula(
      rlang::parse_expr(outcome),
      rlang::parse_expr(predictors)
   )
}

# simulate binary data
binary_sim <- function(
   n = 1000,
   param = "y ~ 1.67 + 1.50*x1 + 1.2*a1",
   data = ,
   family = "binomial",
) {
   
}
