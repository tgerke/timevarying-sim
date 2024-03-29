# set up a function to get a vector of 0/1 from a vector of probabilities
sample_bin <- function(p) {
  purrr::map_int(p, ~ sample(0:1, 1, prob = c(1 - .x, .x)))
}

# simulate GLM data from a user-specified formula
sim_glm <- function(
  data,
  formula,
  family,
  ...
) {
  formula <- rlang::enexpr(formula)
  data <- eval_formula(formula, data)

  lhs <- formula_lhs(formula)

  data[[lhs]] <- switch(
    family,
    "binomial" = sample_bin(1 / (1 + exp(-data[[lhs]]))),
    "gaussian" = data[[lhs]] + rnorm(nrow(data), 0, ...),
    stop("Unknown family '", family, "'")
  )


  data
}

#' Take a formula and a data frame, evaluates the RHS within the data frame
#' and saves it as a column with the name given by the LHS
eval_formula <- function(formula, data) {
  assertthat::assert_that(rlang::is_formula(formula))

  lhs <- rlang::quo_name(formula[[2]])
  data[[lhs]] <- rlang::eval_tidy(formula[[3]], data)

  data
}

formula_lhs <- function(formula) {
  assertthat::assert_that(rlang::is_formula(formula))

  rlang::quo_name(formula[[2]])
}

# examples
#sim_glm(tibble(x = runif(100)), y~5*x, family = "binomial")
#sim_glm(tibble(x = runif(100)), y~5*x, family = "gaussian", sd = 1)