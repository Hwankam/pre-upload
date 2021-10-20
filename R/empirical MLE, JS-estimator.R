rm(list=ls())
data <- read.table("C:/Users/HwanKam/Desktop/고통방/kidney.txt", header=T)
n <- nrow(data)
names(data)
attach(data)
plot(age, tot)

model <- lm(tot ~ age)
summary(model)
abline(model, col='red')

# LSE
y_hat <- fitted(model)


qqnorm(tot)
qqline(tot)

# => 정규성 가정 ckeck

# MLE는 Y|mu 의 분포를 가지고 mu에 대한 MLE 값을 구한다. 즉 MLE of mu is y_i


# JS estimator

## mu_i_js = grand_mean + (1- (n-p-3)sigma02 / S)(mle - grand_mean)

sigma02 <- 1.801^2 # in problem, it is known
s <- 1.801^2 * 155

JS <- c()
for (i in 1:n) {
  JS[i] <- y_hat[i] + (1-(n-4)*sigma02/s)*(tot[i]-y_hat[i])
}



# 3가지 추정량 그림 나타내기
#MLE
plot(age, tot, pch=20, cex=1, type="p", xlab="X ", ylab="y ", main=" ", ylim=c(-7,5), col='red')
par(new = T)
#LSE
plot(age, y_hat, pch=20, cex=1, type="p", xlab="X ", ylab="y ", main=" ", ylim=c(-7,5), col='green')
par(new = T)
#JSE
plot(age, JS, pch=20, cex=1, type="p", xlab="X ", ylab="y ", main=" ", ylim=c(-7,5), col='blue')
