n, m, k = map(int, input().split())
a = [list(map(int, input().split())) for _ in range(n)]
c = [[False]*m for _ in range(n)]

ans = -11111111111
dx = [0,0,1,-1]
dy = [1,-1,0,0]

def go(prev, cnt, s) : #prev : 이전 선택한 칸의 행 번호 
    if cnt == k: #입력한 k 값에 해당할 때까지는 작동 안하는 부분.
        global ans
        if ans < s:
            ans = s # ans 가 최대가 되는 값을 찾아야하기 때문에 
        return
    
    for j in range(prev+1, n*m):
        x = j//m
        y = j%m  # 몫과 나머지를 활용하면 격자점의 모든 점을 다 돌 수 있음.
        if c[x][y]: # 이 부분이 true라는 것은 이미 선택이 되었다는 것. 이미 사용되었거나 인접한 점
            continue
        ok = True
        
        # 선택이 될 수 있는 점 c[x][y] 에 대해서 이제 주변을 탐색해보겠다. 
        
        for i in range(4):
            nx,ny = x + dx[i], y + dy[i]
            if 0 <= nx < n and 0 <= ny < m:
                if c[nx][ny]: # 이 부분이 true라는 것은 이미 상하좌우 주변이 선택되었다는것!
                    ok = False # 특정 셀 주변이 선택되었으므로 false
                    
                    
        # 위의 두가지 for loop 는 결국 한 셀을 선택하고 기존에 false 인지 체크하고(이미 선택) 또한 그 주변이 false인지 모두 체크해서(이미 선택) 이상이 없으면 ok=false로 주는 행위
        
        if ok : 
            c[x][y] = True  # 선택이 되면 true
            go(x*m + y, cnt + 1, s+a[x][y])  # 재귀함수 // 앞에서 선택이 되었기 때문에 그 점을 s 에 추가해줌.
            c[x][y] = False
            
go(-1,0,0)
print(ans)