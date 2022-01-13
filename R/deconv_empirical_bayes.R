rm(list=ls())
library(deconvolveR)
library(distr)

set.seed(42)
N <- 1000
nSIM <- 1000

theta <- ( 7 * rnorm(N, mean=0, sd = 0.5) + runif(N, min = -3, max = 3) ) / 8
data <- sapply(seq_len(nSIM), function(x) rnorm(n=N, mean = theta, sd=1))

point <- seq(-3,3, by=0.05)
results <- apply(data, 2, function(x) deconv(point, X= x, family = "Normal", pDegree=6))

g <- matrix(nrow=length(point), ncol=1000)

for (j in 1:length(point)) {
  
  for (i in 1:1000) {
    
    g[j,i] <- results[i][[1]]$stats[j,"g"]
    
  }
  
}
estimate <- apply(g, 1, mean)
plot(point, estimate/0.05, type='l', xlim = c(-3,3), xlab = "theta", ylab = "g", col='red', )
Mix= (7/8) * dnorm(point,0,0.5) + (1/8) * dunif(point, -3,3)
lines(point, Mix)

hist(theta, probability = T, breaks=50, xlim = c(-3,3))

legend("topright",legend=c("True","Estimates"),fill=c("black","red"))
