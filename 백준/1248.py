def check(index):
    s = 0
    for i in range(index, -1, -1) : #   index부터 1씩 줄여나가면서 loop
        s += ans[i] # s= A[i] + ... + A[k], 즉 s는 합, 스칼라
        if sign[i][index] == 0 :
            if s != 0 :
                return False
            
        elif sign[i][index] <0 :
            if s >= 0 :
                return False
            
        elif sign[i][index] >0 :
            if s <= 0 :
                 return False
    return True

def go(index) :
    if index == n :
        return True
    
    if sign[index][index] == 0 : #대각선
        ans[index] = 0
        return check(index) and go(index+1)
    
    for i in range(1,11): #n은 10보다 작거나 같은 수이므로. 
        ans[index] = i * sign[index][index] # 아무거나 A를 뽑아내면 되기 때문에 부호만 찾아서 i에다 곱함
        if check(index) and go(index + 1) :
            return True
    return False

n = int(input())
s = input() # -+0++++--+ 와 같이 나와야하며 그 개수는 ( n(n+1)/2 개로 해야한다.)
sign = [ [0]*n for _ in range(n) ]
ans = [0] * n
cnt = 0

# 이게 임의로 sign 함수를 우리가 만드는것. 단 s를 고려해서 만들어야 하는 것.
for i in range(n) :
    for j in range(i,n):
        if s[cnt] == '0' :
            sign[i][j] = 0
            
        elif s[cnt] == '+' :
            sign[i][j] = 1
        
        else :
            sign[i][j] = -1 
            
        cnt += 1
        
        
go(0)
print(' '.join(map(str, ans)))