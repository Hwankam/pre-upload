t = int(input())

for _ in range(t):
    m,n,x,y = map(int, input().split())
    x -= 1
    y -= 1
    k = x
    while k < n*m :  # 나머지로 계산하기 때문에 n * m 안에서는 모든 나머지 케이스가 다 나오게 된다
        if k%n == y :
            print(k+1)  # 왜냐면 기존 x에서 1을 뺏기 때문에  
            break
            
        k += m 
        
    else :
        print(-1)