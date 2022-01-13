getwd()
setwd("/Users/hwankam/")
data <- read.csv("./HW3.1.csv")
data

#1.1
fit <- glm(data$y ~ 1 + data$Income..X1. + data$Age..X2. , family=binomial)
summary(fit)


# Newton-Raphson
X <- cbind(1, data[,1:2])
X <- as.matrix(X)
Y <- as.vector(data$y)

beta_new <- c(0, 0 ,0.5)
 


iter <- 1
while(iter < 10000) {
  beta_old <- beta_new
  p <- exp(X %*% beta_old) / (1 + exp(X %*% beta_old))
  v.2 <- diag(as.vector(p*(1-p)))
  deriv_1 <- t(X) %*% (Y - p) 
  deriv_2 <- solve(t(X) %*% v.2 %*% X)
  beta_new <- beta_old + deriv_2 %*% deriv_1
  if ( mean( abs(beta_old - beta_new) ) < 0.001) {break}
  iter <- iter + 1
}

# Fisher scoring Algorithm is same with Newton-Raphson ( beacause of canonical link)

# IRLS algorithm is also same
## I just set negative derivative of score function = XTWX

beta_new <- c(0, 0 ,0.5)



iter <- 1
while(iter < 100000) {
  beta_old <- beta_new
  p <- exp(X %*% beta_old) / (1 + exp(X %*% beta_old))
  Wieghts <- diag(as.vector((p*(1-p))))
  U <- t(X) %*% (Y - p) 
  XTWX <- solve(t(X) %*% Wieghts %*% X)
  beta_new <- XTWX %*% ( t(X) %*% Wieghts ) %*% (X %*% beta_old + solve(Wieghts) %*% (Y-p))
  if ( mean( abs(beta_old - beta_new) ) < 0.001) {break}
  iter <- iter + 1
  
}


#1.2
glm(data$y ~ 1 + data$Income..X1. + data$Age..X2. , family=poisson)


#1.3
beta_new <- c(0, 0 ,0.5)

iter <- 1
while(iter < 100000) {
  beta_old <- beta_new
  p <- exp(X %*% beta_old) / (1 + exp(X %*% beta_old))
  Wieghts <- diag(as.vector((p*(1-p))))
  U <- t(X) %*% (Y - p) 
  XTWX <- solve(t(X) %*% Wieghts %*% X)
  beta_new <- XTWX %*% ( t(X) %*% Wieghts ) %*% (X %*% beta_old + solve(Wieghts) %*% (Y-p))
  if ( mean( abs(beta_old - beta_new) ) < 0.001) {break}
  iter <- iter + 1
  
}

theta <- X %*% beta_new
mu_hat <- exp(theta) / (1+ exp(theta))

# saturated model을 어떻게 구할 것인가가 핵심이었다.
# saturated model은 y의 값을 p 대신에 넣어주면 된다, 다만 bernoulli 에서는 로그안의 값이 0 이된다.
# 
# 그래서 y=0이면 -2log(1-mu_hat), y=1이면 -2log(mu_hat) 으로 잡은 벡터의 합을 Deviance로 칭한다. 

# Deviance Residual
DD <- ifelse(Y==1, -2 * log(mu_hat), -2*log(1-mu_hat) )
sign <- ifelse(Y-mu_hat >0, 1, -1)
summary(sqrt(DD)*sign)

# Pearson Residual
(Y-mu_hat) / sqrt(mu_hat * (1-mu_hat))





#3. CMH

rm(list=ls())
library(tidyverse)

data <- tibble(
  Victim = rep( c("Black","White"), each=4), 
  Defender = rep( rep( c("Black", "White"), each=2), 2),
  Penalty = rep( c("no","yes"), 4),
  count = rev(c(53, 414, 11, 37, 0, 16, 4, 139))
  
)
data       

dat <- xtabs(count ~   Penalty + Victim + Defender , data=data)
dat

mantelhaen.test(dat)

######### CMH General Association

CMH_G_S <- function(mat){
  ni. <- apply(mat,1,sum)
  n.j <- apply(mat,2,sum)
  N <- sum(mat)
  pi. <- ni./N
  p.j <- n.j/N
  n <- as.vector(t(mat))
  m <- N*kronecker(pi.,p.j)
  Dpi. <- diag(pi.) 
  Dp.j <- diag(p.j) 
  S1 <- (Dpi. - pi. %*% t(pi.))
  S2 <- (Dp.j - p.j %*% t(p.j))
  Sigma <- (N^2)/(N-1) * kronecker(S1,S2)
  r <- nrow(mat)
  c <- ncol(mat)
  A1 <- cbind(diag(r-1), matrix(0,r-1))
  A2 <- cbind(diag(c-1), matrix(0,c-1))
  A <- kronecker(A1, A2)
  G <- A%*%(n-m)
  V_G <- A%*%Sigma%*%t(A)
  return(list(G= G, Var_G = V_G))
}

r <- nrow(dat[,,1])
c <- ncol(dat[,,1])
M <- matrix(0, (r-1)*(c-1), 1)  ## (r-1)(c-1)*1
V_M <- matrix(0, (r-1)*(c-1), (r-1)*(c-1))  ## (r-1)(c-1)*(r-1)(c-1)

s <- dim(dat)[3] #defender type

for(i in  1:s){
  mat <- dat[,,i] 
  M1 <- CMH_G_S(mat)$G 
  M <- M + M1
  V_M1 <- CMH_G_S(mat)$Var_G
  V_M <- V_M + V_M1
}
(Q_G <- t(M)%*%solve(V_M)%*%M)
(df <- (r-1)*(c-1))
1-pchisq(Q_G, df) # reject 


1-pchisq(5.5, 2)
