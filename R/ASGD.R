## Normal case
rm(list=ls())
library(mvtnorm)

# d = 5
d <- 5
set.seed(42)
data_a <- rmvnorm(100000, mean=rep(0,d), sigma = diag(d))
true_coefficients <- runif(d, 0, 1)
epsilon <- rnorm(100000, mean = 0, sd=1)
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

m <- 0 ; l <- 0 ; v <- 0 ; P <- 0 ; q <- 0 ; V <- 0 ; W <- 0 ; xn <- rep(0, d)
xn_bar <- 0

### rep( ) is column vector // data_b[1:1+i] also column vector


for (i in 0:1){
  xn_bar <- rep(mean(xn), d)
  
  if (i == 0) {
    xn <- xn + 0.5*(i+1)^(-alpha) *  ( t(t(data_a[1:(i+1), ]) %*% data_a[1:(i+1), ] %*% xn) - t( t(data_a[1 : (i+1),] ) * data_b[1 : (i+1) ] ))
  }

  else { xn <- xn + 0.5*(i+1)^(-alpha) *  ( t(data_a[1:(i+1), ]) %*% data_a[1:(i+1), ] %*% xn - t(data_a[1 : (i+1),] ) %*% data_b[1 : (i+1) ] )
  }  
  
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
}




0.5*(i+1)^(-alpha)
( t(data_a[1:(i+1), ]) %*% data_a[1:(i+1), ] %*% xn - t(data_a[1 : (i+1),] ) %*% data_b[1 : (i+1) ] )
i
sum(i+1 == f_am) == 1
# if i=0 then we should have to trace (why?)
## i<-0
## t(t(data_a[1 : (i+1),] ) * data_b[1 : (i+1) ])
## t(t(data_a[1:(i+1), ]) %*% data_a[1:(i+1), ] %*% xn)
## i<- 2
## t(data_a[1 : (i+1),] ) %*% data_b[1 : (i+1) ]
## t(data_a[1:(i+1), ]) %*% data_a[1:(i+1), ] %*% xn

i <- 0
xn <- xn - 0.5*(i+1)^(-alpha) *  ( t(t(data_a[1:(i+1), ]) %*% data_a[1:(i+1), ] %*% xn) - t( t(data_a[1 : (i+1),] ) * data_b[1 : (i+1) ] ))
xn_bar <- ( i * xn_bar + xn ) / (i+1)


S/v

hat_Large_sigma_F <- list()





hat_Large_sigma_NOL <-  
