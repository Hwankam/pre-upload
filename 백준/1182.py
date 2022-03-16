n,m = map(int,input().split())
a = list(map(int, input().split()))
ans = 0
for i in range(1, (1 << n)):
    s = sum(a[k] for k in range(n) if (i & (1 << k)) > 0) # 비트마스크 i에 대해 k가 들어있는지 아닌지 체킂
    if m==s:
        ans += 1
    
print(ans)
