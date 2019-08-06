# set up a function to get a vector of 0/1 from a vector of probabilities
sample_bin <- function(p) {
   map_int(p, ~ sample(0:1, 1, prob = c(1 - .x, .x)))
}

