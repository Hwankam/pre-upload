rm(list=ls())
set.seed(42)
a <- rnorm(100)
 
# 누적분포함수 그리기 (ecdf 사용)
plot(ecdf(a), main ="ecdf 함수")
 
 
 
 
# 사용자정의 함수 활용해서 누적분포함수 그리기
cdf <- function(x) {
  mean(a < x)
}
 
cdf(a<2)
number <- sort(runif(1000, min=-3, max=3))
cdf(0.2)
 
vector_y <- c()
for (i in 1:1000) {
  vector_y[i] <- cdf(number[i])
}
 
 
plot(x=number, y=vector_y, main = "사용자 정의함수", xlab='X', ylab='Fn(X)')
 
 
CDF <- function(a){mean(sample<a)}
CDF(160)