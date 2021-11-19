set.seed(42)
sample <- rgamma(1000,10,5)
Fn <- ecdf(sample)

X <- sort(sample)
e_cdf <- 1:length(X) / length(X)
lambda_high <-X[which(e_cdf >= 0.975)[1]]
lambda_low <- X[which(e_cdf >= 0.025)[1]]


plot(Fn)
abline(h = 0.975, col="red", lwd = 2)
abline(h = 0.025, col="red", lwd = 2)
abline(v = lambda_high, col="blue", lwd = 0.5)
abline(v = lambda_low, col="blue", lwd = 0.5)
text(lambda_high,0,"3.3666979")
text(lambda_low,0,"0.9403073")

c(lambda_low, lambda_high) ## [1] 0.9403073 3.3666979

####################################################################


rm(list=ls())
getwd()
data <- read.table("./table.txt", header = T)


eigen_f <- function(x){
  cor_mat <- cor(x)
  eigenratio <- max(eigen(cor_mat)$values)/sum(eigen(cor_mat)$values)
  return(eigenratio)
}

## get "bcajack" R function from "efron.web.stanford. edu under [Talks]” 

bcajack(data,2000, func = eigen_f, m= nrow(data))

