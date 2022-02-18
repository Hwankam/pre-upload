n = int(input())

ans = 0
start = 1
length = 1
while start <= n :
    end = 10 * start -1   # start를 1,2,3, 이렇게 주고 10의 거듭제곱 형태로 만들어나가려고 하면 시간초과가 걸린다.
    if end > n :
        end = n
    ans += (end - start +1) * length
    start *= 10
    length += 1
    
print(ans) 