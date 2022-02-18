def go(sum, n) :
    if sum > n:
        return 0
    if sum == n :
        return 1
    
    now = 0 
    
    for i in range(1,4) : 
        now += go(sum + i, n)
    
    return now

t = int(input())
for _ in range(t):
    n = int(input())
    print(go(0,n))