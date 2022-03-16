# 다음 순열

def next_permut(a) :
    i = len(a) - 1 
    while i > 0 and a[i-1] >= a[i] :
        i -= 1 
    if i <= 0:
        return False ## 마지막 수열
    
    j = len(a) -1 
    while a[j] <= a[i-1]: 
        j -= 1
        
        
    a[i-1],a[j] = a[j], a[i-1]
    
    j = len(a) - 1
    while i < j :
        a[i],a[j] = a[j],a[i]
        i += 1
        j -= 1
    
    return True ##

n = int(input())
a = list(range(1,n+1))

while True:
    print(' '.join(map(str,a))) # 기본 오름차순으로 하나 보이고
    if not next_permut(a): # next_permut(a) 함수 내에서 계속 a를 바꿈 => print 할때마다 다른 변수가 계속 나오게 됨
        break
