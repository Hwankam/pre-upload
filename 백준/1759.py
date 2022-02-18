# 우선 check 함수를 먼저 만들어준다.

def check(password) :
    ja = 0
    mo = 0
    for x in password :
        if x in 'aeiou':
            mo += 1
        else :
            ja += 1
    return ja>=2 and mo>=1  ## if 문과 비슷한데, 해당 조건에 맞을 때 return을 하라는 말임

def go(n, alpha, password, i):
    if len(password) == n :
        if check(password):
            print(password)
        return
    
    if i >= len(alpha) :
        return
    
    go(n, alpha, password+alpha[i], i+1)
    go(n, alpha, password, i+1)
    
n, m = map(int, input().split()) #문제의 요구사항에 n,m 으로 나눠서 출력해줘야하는게 있음
a = input().split()
a.sort()

go(n, a, "",0)
    