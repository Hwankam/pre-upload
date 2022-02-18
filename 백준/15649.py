import sys 

# n 개 중에서 m 개를 뽑는 것.
n,m = map(int, input().split())
c = [False]*(n+1) # 사용했는지 안했는지에 대한 표식
a = [0] * m 

def go(index, n, m) :
    if index == m :
        sys.stdout.write(' '.join(map(str,a))+ '\n')
        return
    
    for i in range(1, n+1):
        if c[i] :
            continue
        
        c[i] = True
        a[index] = i
        go(index+1, n, m)
        c[i] = False 
        
        
go(0,n,m)