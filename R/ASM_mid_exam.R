rm(list=ls())

#Q1 
# 
c =2
x <- seq ( -10 ,10 , by =0.01)
uhat1 <-x * ( abs ( x ) >c )
uhat2 <-x * ( abs ( x ) >c ) * (1 - c ^2 / x ^2)
par ( mfrow = c (1 ,2) )
plot (x , uhat1 , type = "l", xlab = " uMLE " , ylab = " uhat1 " )
plot (x , uhat2  ,type = "l", xlab = " uMLE " , ylab = " uhat2 " )


# Q2
par ( mfrow = c (1 ,2) )

# plot the function - risk 1

## if you want to plot of variable u, you use the seq() to set variable
u <- seq ( -10 ,10 ,0.01)
risk1 <- rep (0 , length ( u ) )
for ( i in 1: length ( u ) ) {
  x <- rnorm (100000 , u [ i ] ,1)
  uhat1 <-x * ( abs ( x ) >c )
  risk1 [ i ] <- mean ( ( uhat1 - u [ i ]) ^2 )
}
plot (u , risk1, type = "l"  , ylim = c (0 ,3.5) )


# plot the function - risk 2

risk2 <- rep (0 , length ( u ) )
for ( i in 1: length ( u ) ) {
  x <- rnorm (100000 , u [ i ] ,1)
  uhat2 <-x * ( (1 -( c ^2 / x ^2) ) + abs (1 -( c ^2 / x ^2) ) ) * 0.5
  risk2 [ i ] <- mean ( ( uhat2 - u [ i ]) ^2 )
}
plot (u , risk2, type = "l" , ylim = c (0 ,3.5) )




# Q4
library("mvtnorm")

u = c ( rep (0 ,10) , rep (5 ,10) )
M =100000; n =20
X <- rmvnorm (M , mean =u , sigma = diag (20) ) # diag(20) is size 20 by 20 identity matrix
U <- matrix ( rep (u , M ) , byrow =T ,M , n )
uhatJS <- matrix (0 ,M , n )
uhat1 <- matrix (0 ,M , n )
uhat2 <- matrix (0 ,M , n )
for ( i in 1: M ) {
  x <-X [i ,]
  uhatJS [i ,] <- mean ( x ) +(1 - (n -3) / sum ( (x - mean ( x ) ) ^2 ) ) * (x - mean ( x )
  )
  uhat1 [i ,] <-x * ( abs ( x ) >c )
  uhat2 [i ,] <-x * ((1 - c ^2 / x ^2) + abs (1 - c ^2 / x ^2) ) * 0.5
}
uJShatrisk <- sum (( uhatJS - U ) ^2) / M
uhat1risk <- sum (( uhat1 - U ) ^2) / M
uhat2risk <- sum (( uhat2 - U ) ^2) / M
uJShatrisk ; uhat1risk ; uhat2risk


# Q5

