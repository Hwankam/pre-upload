prostmat <- read.csv("http://web.stanford.edu/~hastie/CASI_files/DATA/prostmat.csv")



dim(prostmat)
type <- grep('cancer', names(prostmat))
cancer <- prostmat[,type]
control <- prostmat[,-type]

C <- c(rep("cancer",52), rep("control",50))
statistics <- c()

for (i in 1:6033) {
  
  a <- as.vector(as.matrix(cancer[i,1:52]))
  b <- as.vector(as.matrix(control[i,1:50]))
  
  D <- c(a,b)
  
  tstat <- t.test(D ~ C, var.equal = T)$statistic
  statistics[i] <- tstat
}


large_t <- sort(statistics, decreasing=T )[1:50]
p_i <- 1-pt(large_t, 100)

fig.size = c(10,50)
plot(x=c(1:50),p_i, col = "blue", xlim = c(0,50), ylim=c(0,0.002), cex=0.3, xlab = 'index i', ylab = 'p-value')

xx <- rep(c(0:50))
yy <- 0.1 / (nrow(prostmat) - xx +1)
zz <- 0.2 * xx /nrow(prostmat)
points(xx, yy, type='l')
points(xx, zz, type='l', col='red')
text(45,0.00005, "Holm's")
text(7,-0.00005, "i=7")
arrows(6.7, -0.00003 , 7, 0.00001, code=2, length = 0.1, col=6)
text(45,0.0015, "FDR", col='red')
