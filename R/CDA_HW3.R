#1
rm(list=ls())
#fisher exact test

How_to <- c("Surgery","Radiation Theapy")
Controlled <- c("Cancer Controlled", "Cancer Not Controlled")
data <- c(21,15,2,3)
dd <- cbind(expand.grid(How_to=How_to,Controlled=Controlled ),data)
table <- xtabs(data~How_to+Controlled, data = dd)
table
dd


fisher.test(table, alternative = "two.sided")
fisher.test(table, alternative = "greater")
fisher.test(table, alternative = "less")

# what is null hypothesis? Null : we cannot detect the difference(fisher tea example) , there are independence
# alternative hypothesis: true odds ratio is not equal to 1

p0 <- choose(18,0) * choose(23,5) / choose(41,5)

p1 <- choose(18,1) * choose(23,4) / choose(41,5)

p2 <- choose(18,2) * choose(23,3) / choose(41,5)

p3 <- choose(18,3) * choose(23,2) / choose(41,5)

p4 <- choose(18,4) * choose(23,1) / choose(41,5)

p5 <- choose(18,5) * choose(23,0) / choose(41,5)


1-p2 # "two.sided" p-value.

p3 + p4 + p5 #:"greater" p-value.

p0 + p1 + p2 + p3 #  "less"  p-value.

table
addmarigins(table)
prop.table(table) 

barplot(table, legend=T, beside=T, ylim=c(0,30))

chisq.test(table)
# Chi-squared approximation may be incorrect 
# chisq.test(table)$expected show expected cell, but some cell is too low under 5

chisq.test(table)$observed
chisq.test(table)$expected
t.orig <-chisq.test(table)$statistic

# what is difference between independence test and homogeniety test
# Independence test : X and Y is randoem, Homegeniety test : X is fixed and Y is random

#permuation test in contingency table (homogeniety test)
perm <- c()
for (i in 0:5) {
  How_to <- c("Surgery","Radiation Theapy")
  Controlled <- c("Cancer Controlled", "Cancer Not Controlled")
  data <- c(18+i,18-i,5-i,0+i)
  dd <- cbind(expand.grid(How_to=How_to,Controlled=Controlled ),data)
  table <- assign(paste0("table",i),xtabs(data~How_to+Controlled, data = dd))
  perm[i] <- chisq.test(table)$statistic
  }


permutation <- sample(perm, 500, replace=T)
mean(permutation>t.orig)





#4

#typical permuatation test

sample1 <- rnorm(10, mean = 0 , sd = 1)
sample2 <- rnorm(10, mean = 0 , sd = 1)


data <- c(sample1, sample2)
index <- c(rep("a",10),rep("b",10))
t.origin <- t.test(data ~ index, var.equal=T)$statistic

t_value <- c()
for (i in 1:500) {
  set.seed(i)
  index.shuffle <- sample(index, 20, replace=F)
  t_value[i] <- t.test(data ~ index.shuffle, var.equal=T)$statistic
}

hist(t_value)
abline(v=t.origin, col='red')
permutation_p_value <- mean(t_value>t.origin)
permutation_p_value
