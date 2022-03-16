n,m = map(int, input().split())
a = [list(map(int,list(input()))) for _ in range(n)]
ans = 0
for s in range(1<<(n*m)): # 비트마스크
    sum = 0
    for i in range(n):
        cur = 0
        for j in range(m):
            k = i*m + j # 행렬을 행단위로 쭉 폈을때 A[i][j]의 위치
            if (s & (1<<k)) == 0: # i를 먼저 for loop에 넣었으므로 행을 기준으로 보고 있으며 가로로 자른 수를 0으로 놓은것
                cur = cur * 10 + a[i][j]
            else :
                sum += cur
                cur = 0
        sum += cur
    
    for j in range(m):
        cur = 0
        for i in range(n):
            k = i*m + j
            if (s & (1<<k)) != 0:
                cur = cur * 10 + a[i][j]
            else :
                sum += cur
                cur=0
        sum += cur
    
    ans = max(ans, sum)
    
print(ans)
        