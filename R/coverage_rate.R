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


###################################################
# overlapping case

## initial value

m <- 0 ; l <- 0 ; v <- 0 ; P <- 0 ; q <- 0 ; V <- 0 ; W <- 0 ; xn <- rep(0,5)
#m <- 0 ; l <- 0 ; v <- 0 ; P <- 0 ; q <- 0 ; V <- 0 ; W <- 0 ; xn <- c(0.1, -0.3, 1.3, 2.2, 0.7)
xn_bar <- 0
hat_Large_sigma_F<- 0
CI11 <- c()
CI12 <- c()
error <- c()

### rep( ) is column vector // data_b[1:1+i] also column vector
## slicing makes column vector
vv <- rep(1,d)

for (i in 0:99999){
  
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
  CI11[i+1] <- sum(xn_bar) - qnorm(0.975, mean = 0, sd=1)* sqrt( t(vv) %*% hat_Large_sigma_F %*% vv ) / sqrt(i+1)
  CI12[i+1] <- sum(xn_bar) + qnorm(0.975, mean = 0, sd=1)* sqrt( t(vv) %*% hat_Large_sigma_F %*% vv ) / sqrt(i+1)
  
  error[i+1] <-  sqrt(i+1) * t(vv) %*% (xn_bar - true_coefficients) /  sqrt( t(vv) %*% hat_Large_sigma_F %*% vv )
  
}

cbind(CI11, CI12)
plot(c(1:length(CI11)), CI12-CI11, ylim= c(0,1))

######################################################
# Non-overlapping case


## sigma and sigma hat


Large_sigma <- diag(d)


## initial value

m <- 0 ; l <- 0 ; v <- 0 ; P <- rep(0,d) ; q <- 0 ; V <- 0 ; W <- 0 ; xn <- rep(0,5)
#m <- 0 ; l <- 0 ; v <- 0 ; P <- 0 ; q <- 0 ; V <- 0 ; W <- 0 ; xn <- c(0.1, -0.3, 1.3, 2.2, 0.7)
xn_bar <- 0
hat_Large_sigma_F_NOL <- c()
CI21 <- c()
CI22 <- c()
error_NOL <- c()

### rep( ) is column vector // data_b[1:1+i] also column vector
## slicing makes column vector

for (i in 0:99999){
  
  xn <- xn - 0.5*(i+1)^(-alpha) *  ( data_a[(i+1), ] %*% t(data_a[(i+1), ]) %*% xn - data_a[(i+1),]  * data_b[(i+1) ] )
  
  xn_bar <- ( i * xn_bar + xn ) / (i+1)
  
  if ( sum(i+1 == f_am) == 1 ) {
    l <- 1
    W <- xn
    q <- q + l^2
    V <- V + W %*% t(W)
    P <- P + l*W
  }
  
  else {
    l <- l+1
    W <- W + xn
    q <- q
    V <- V
    P <- P
  }
  
  S_prime <- W %*% t(W) + l^2 * xn_bar %*% t(xn_bar) - l*W%*% t(xn_bar) - l * xn_bar %*% t(W)
  S <- V + q* xn_bar %*% t(xn_bar) - P %*% t(xn_bar) - xn_bar %*% t(P) + S_prime
  hat_Large_sigma_F_NOL <- S / (i+1)  
  CI21[i+1] <- sum(xn_bar) - qnorm(0.975, mean = 0, sd=1)* sqrt( t(vv) %*% hat_Large_sigma_F %*% vv ) / sqrt(i+1)
  CI22[i+1] <- sum(xn_bar) + qnorm(0.975, mean = 0, sd=1)* sqrt( t(vv) %*% hat_Large_sigma_F %*% vv ) / sqrt(i+1)
  
  error_NOL[i+1] <- sqrt(i+1) * t(vv) %*% (xn_bar - true_coefficients) /  sqrt( t(vv) %*% hat_Large_sigma_F_NOL %*% vv )
  
}


####################################################################33
# CI

cbind(CI21, CI22)


plot(c(1:length(CI11)), CI12-CI11, ylim= c(0,1), type='l')
lines(CI22-CI21, col = 'red')


######################################################
# standardized error to normal
hist(error_NOL, xlim = c(-5,10), breaks = 800)

hist(error, xlim = c(-5, 5), breaks = 800)

hist(error)
sum(error>0.5)
sum(error > 1.5)
sum(error < -3)

sum(error_NOL > 0.5)
sum(error_NOL > 1.5)
sum(error < -3)
