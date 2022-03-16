# 이 문제는 python에서 TOP DOWN 방식으로 풀 수 없다.

n = int(input())
d = [0]*(n+1) # d는 memoization

d[1] = 0
for i in range(2,n+1):
    d[i] = d[i-1] + 1
    if i%2 == 0 and d[i] > d[i//2] + 1 :
        d[i] = d[i//2] + 1
    if i%3 == 0 and d[i] > d[i//3] + 1 :
        d[i] = d[i//3] + 1
        
print(d[n]) 