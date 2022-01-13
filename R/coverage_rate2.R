## Normal case
rm(list=ls())
library(mvtnorm)


C <- 1
alpha <- 0.505
m <- c(1:1000)
am <- C * m^(2/(1-alpha)) 
f_am <- floor(am)
d <- 5
Large_sigma <- diag(d)
vv <- rep(1,d)
coverage <- matrix(0,100,3)
true_coefficients <- runif(d, 0, 1)
tt <- sum(true_coefficients)
epsilon <- rnorm(120000, mean = 0, sd=1)
data_a <- rmvnorm(120000, mean=rep(0,d), sigma = diag(d))
is.data.frame(data_a)
is.matrix(data_a)

for (i in 1:20){
  set.seed(i)
  assign(paste0("data_a" , i) , rmvnorm(120000, mean=rep(0,d), sigma = diag(d)))
}
paste0("data_a",2)


# d = 5

for (k in 1 : 100) {
  number <- 0 
  for (j in c(50000, 75000, 100000)) {
    number <- number + 1
    data_a <- data_a[1:j,]
    data_b <- data_a %*% true_coefficients + epsilon[1:j]
    
    m <- 0 ; l <- 0 ; v <- 0 ; P <- 0 ; q <- 0 ; V <- 0 ; W <- 0 ; xn <- rep(0,5)
    xn_bar <- 0
    hat_Large_sigma_F<- 0
    CI11 <- c()
    CI12 <- c()
    
    for (i in 0:(j-1)){

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
      
    tf1 <- c()
      
    for (c in 1:length(CI11)) {
      if ( CI11[c] <= tt & CI12[c] >= tt ) {
         tf1[c] <- 1    
        }
      else {
        tf1[c] <- 0
        }
    } 
      
    coverage[k, number] <- sum(tf1)/length(tf1)
    
   }
  }
}



coverage[1,2] <- 3
coverage

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

for (i in 0:49999){
  
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
  
}



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

for (i in 0:49999){
  
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
}


####################################################################33
# CI coverage rate plot

tf1 <- c()
tt <- sum(true_coefficients)
for (i in 1:length(CI11)) {
  if (CI11[i] <= tt & CI12[i] >= tt) {
    tf1[i] <- 1    
  }
  else {
    tf1[i] <- 0
  }
} 

sum(tf1)/length(tf1)



tf2 <- c()
tt <- sum(true_coefficients)
for (i in 1:length(CI21)) {
  if (CI21[i] <= tt & CI22[i] >= tt) {
    tf2[i] <- 1    
  }
  else {
    tf2[i] <- 0
  }
} 

sum(tf2)/length(tf2)



######################################################
# standardized error to normal
hist(error_NOL, xlim = c(-5,10), breaks = 800)

hist(error, xlim = c(-5, 5), breaks = 800)

