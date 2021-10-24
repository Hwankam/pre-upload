#1 paste and paste0
## paste0 is paste the sentence without blank


#2 substr
## in string, we can find the character considering where to start and where to finish
substr("howtoknow", 1,4)


#3 boolean 
## we can use boolean to build short code
kk <- sample(c(1:10), 10)
sum(kk%%2)


#4 vector to matrix short code
kk <- sample(c(1:10), 10)
dim(kk) <- c(2,5)
kk

#5 list, unlist
## List has nested structure. So to use the argument conveniently we can use unlist

#6 histogram and density plot together
hist(x, probability=T)

y <- seq(from=5,to=8,by=0.01)
fy <- dnorm(y, mean=7, sd=0.1)
lines(y,fy)
## we put the argument "probability=T" to alter y-axis to probability

#7 When I want to find variable corresponding with some condition
Table$variable1[variable2 == condition]

#8 plot together
par(new=T)
plot(x=x , y=y, ann=F, axes=F )
