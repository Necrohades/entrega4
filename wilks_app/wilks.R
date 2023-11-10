lambda.wilks.betas <- function(n, p, a, b) {
  lambda <- rep(1, n)
  
  for (i in 1:b) {
    lambda = lambda * rbeta(n, (a + i - p) / 2, p / 2)
  }
  
  return(lambda)
}

lambda.wilks.wishart <- function(n,p,a,b) {
  
  Sigma=diag(1,nrow=p)
  A <- rWishart(n,a,Sigma)
  B <- rWishart(n,b,Sigma)
  A
  B
  res=1:n
  
  for (i in 1:n){
    res[i]=det(A[,,i])/det(A[,,i]+B[,,i])
  }

  return (res)
}
