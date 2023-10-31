lambda.wilks <- function(n, p, a, b) {
  lambda <- rep(1, n)
  
  for (i in 1:b) {
    lambda = lambda * rbeta(n, (a + i - p) / 2, p / 2)
  }
  
  return(lambda)
}
