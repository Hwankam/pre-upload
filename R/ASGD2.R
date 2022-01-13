## Normal case
rm(list=ls())
library(mvtnorm)

# d = 5
d <- 5
set.seed(42)
data_a <- rmvnorm(1000000, mean=rep(0,d), sigma = diag(d))
true_coefficients <- runif(d, 0, 1)
epsilon <- rnorm(1000000, mean = 0, sd=1)
data_b <- data_a %*% true_coefficients + epsilon 

# set C = 1
# sequence a_m


C <- 1
alpha <- 0.505
m <- c(1:1000)
am <- C * m^(2/(1-alpha)) 
f_am <- floor(am)




## sigma and sigma hat


Large_sigma <- diag(d)


## initial value

m <- 0 ; l <- 0 ; v <- 0 ; P <- 0 ; q <- 0 ; V <- 0 ; W <- 0 ; xn <- c(0.1, 0.3, -1, 2.0, -1.7)
#m <- 0 ; l <- 0 ; v <- 0 ; P <- 0 ; q <- 0 ; V <- 0 ; W <- 0 ; xn <- c(0.1, -0.3, 1.3, 2.2, 0.7)
xn_bar <- 0

### rep( ) is column vector // data_b[1:1+i] also column vector
## slicing makes column vector
pp <- c()

for (i in 0:1000000){
  xn_bar <- rep(mean(xn), d)
  
    xn <- xn - 0.5*(i+1)^(-alpha) *  ( data_a[(i+1), ] %*% t(data_a[(i+1), ]) %*% xn - data_a[(i+1),]  * data_b[(i+1) ] )

  xn_bar <- ( i * xn_bar + xn ) / (i+1)
  
  if ( sum(i+1 == f_am) == 1 ) {
    l <- 1
    W <- xn
  }
  
  else {
    l <- l+1
    W <- W + xn
  }
  
  q <- q + l^2
  v <- v + l
  V <- V + W %*% t(W)
  P <- P + l*W
  S <- V + q* xn_bar %*% t(xn_bar) - P %*% t(xn_bar) - xn_bar %*% t(P)
  hat_Large_sigma_F <- S / v   
  kk <- hat_Large_sigma_F - Large_sigma
  pp[i+1] <- log(sqrt(max(abs(eigen(t(kk) %*% kk)$values))))
}

plot(pp)


rrr2 = c()
for (i in 1:20000) {
  rrr2[i] =  ( (i)^(-alpha) ) / 2 
}

rrr2[1:20]

11/65
1/8
1.1/6.5
(1.05-0.224) / (11.5-5) 
1.5 / 7
