n = int(input())  # target
m = int(input()) # 고장난 키 입력

broken = [False] * 10    # 고장난 키 0 ~ 9

if m > 0 :
    a = list(map(int, input().split()))
    
else :
    a = []
    
for x in a : 
    broken[x] = True
    
def possible(c):  # c는 숫자버튼을 눌러서 최대한 가깝게 이동하려는 번호
    if c == 0 :
        if broken[0] : 
            return 0
        
        else :
            return 1
    
    l = 0     
    while c > 0 :
        if broken[c%10] : 
            return 0  # c //=10를 통해 c 를 업데이트 해나가는데, c%10 의 나머지가 계속해서 고장난 버튼이라면 결국 l이 아닌 0을 return 하게 되는것이고 그렇지 않고 하나라도 살아있다면 c 의 자리수는 유지한 채로 어떠한 버튼으로 옮겨갈 것.
        
        l += 1     
        c //= 10
        
    return l # l은 c의 자리수 ( 자리수만큼 번호를 눌러야하기 때문에)

ans = abs(n-100)

for i in range(0, 1000000 + 1):
    c = i
    l = possible(c)
    if l > 0 : 
        press = abs(c-n)
        if ans > l + press :
            ans = l + press  # ans 가 더 크다면, 최소가 되는 값인 l + press 를 답으로 선택한다. 
            
print(ans)


        