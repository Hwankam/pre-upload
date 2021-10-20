leukemia_big <- read.csv("http://web.stanford.edu/~hastie/CASI_files/DATA/leukemia_big.csv")

fix(leukemia_small) # 새로운 창으로 데이터 테이블 보여주기
summary(leukemia_small) # 각 변수별 요약
dim(leukemia_small) # 사이즈 체크

#특정 조건 추출하기 1
type <- grep('ALL', names(leukemia_small)) 
ALL <- leukemia_small[,type]
AML <- leukemia_small[,-type]

#특정 조건 추출하기 2
library(tidyverse) # dplyr ggplot2 등등 사용 가능
ALL <- dplyr::select(leukemia_big, contains('ALL'))
AML <- dplyr::select(leukemia_big, -contains('ALL'))

### we choose 136 gene (simulation from textbook)

a <- as.vector(as.matrix(ALL[136,1:47])) #데이터프레임 안에 있는 원소들을 긴 벡터로 추출하기 위해 as.vector(as.matrix()) 를 사용한다.
b <- as.vector(as.matrix(AML[136,1:25]))

C <- c(rep("a",47),rep("b",25))
D <- c(a,b)

t.original <- t.test(D ~ C, var.equal=F)$statistic #same below

## permutation test
stat <- c()
for (i in 1:1000) {
  set.seed(i+1000)
  C.shuffle <- sample(c, size=72, replace=T)
  stat[i] <- t.test(D ~ C.shuffle, var.equal=F)$statistic
}
hist(stat)
abline(v=t.original, col="blue")
p_value <- mean(stat < t.original)
p_value

################################### 교수님 코드

l <- leukemia_big %>%
  tibble :: rownames_to_column() %>% #첫번째 column에 rowname을 주는 칼럼을 새로 만드는 것. 
  pivot_longer(-rowname) %>% # 데이터를 long_format으로 변경(nowname은 제외)
  pivot_wider(names_from=rowname, values_from=value)
l
## 이 결과 만들어지는 행렬이 결국 leukemia_big의 transpose matrix이다. 

Label <- ifelse(grepl("ALL",l$name), "ALL","AML") #grep와의 차이 : grep 는 인덱스 출력, grepl은 논리값 출력 
l <- l %>% select(-1) # 첫번째 column은 제외된다.
data <- data.frame(x = l[,136],Label) # x와 label 값을 데이터프레임으로 만들어라. 

t.orig <-  t.test(X136 ~ Label, data = data)$statistic
md.orig <- colMeans(l[Label == "ALL",136]) - colMeans(l[Label == "AML",136])  

## 실제 permutation test를 하기 위해서 loop를 활용해서 시행횟수를 여러번 만들기
perm <- data.frame(md = NULL, t = NULL) 
# 빈 데이터 프레임을 먼저 하나 생성, md, t 는 행과 열의 이름으로 내가 임의로 지정한 것.

for(i in 1:1000){
  perm.Label <- gtools::permute(Label)
  perm.data <- data.frame(x = l[,136], Label = perm.Label)
  t <- t.test(X136 ~ Label, data = perm.data)$statistic
  md <- colMeans(l[perm.Label == "ALL",136]) - colMeans(l[perm.Label == "AML",136])
  perm <- rbind(perm,data.frame(md = md, t = t))
} 


hist(perm$t)
abline(v = t.orig, col = "blue")
(pvalue <- mean( perm$t < t.orig ) )

hist(perm$md)
abline(v = md.orig, col = "blue")
(pvalue <- mean( perm$md < md.orig ) )