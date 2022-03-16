def next_permutation(a):
    i = len(a)-1
    while i > 0 and a[i-1] >= a[i]:
        i -= 1
    if i <= 0:
        return False
    j = len(a)-1
    while a[j] <= a[i-1]:
        j -= 1

    a[i-1],a[j] = a[j],a[i-1]

    j = len(a)-1
    while i < j:
        a[i],a[j] = a[j],a[i]
        i += 1
        j -= 1

    return True

n = int(input())
w = [list(map(int,input().split())) for _ in range(n)] # 비용
d = list(range(n))  
ans = 2147483647
while True:
    ok = True
    s = 0
    for i in range(0, n-1):
        if w[d[i]][d[i+1]] == 0:
            ok = False
            break
        else:
            s += w[d[i]][d[i+1]]
    if ok and w[d[-1]][d[0]] != 0: # 마지막에서 제일 처음으로 돌아오는 것까지 체크해줘야함
        s += w[d[-1]][d[0]]
        ans = min(ans, s)
    if not next_permutation(d):
        break
    if d[0] != 0:
        break
print(ans)
