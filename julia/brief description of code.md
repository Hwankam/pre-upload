## 코드 설명

1. 각 figure를 만들어내기 위한 함수를 만들고 이를 각각 ASGD_12, ASGD_3, ASGD_4로 지정했다. 각 함수는 내부 구조가 유사하며, 두 가지 알고리즘과 초기값을 baseline으로 한 뒤, 원하는 결과를 얻기 위한 식과 output을 추가하는 형식으로 작성되었다. 

2. 계산의 효율성을 위해 Matrix 간의 곱을 지양하고 Vector 와 Matrix의 결합식에서 Vector 계산을 우선으로 하도록 코드를 구성했다. 

3. 25만개의 sample 데이터를 200번 생성하는데 시간과 비용을 절약하기 위해, response / explanatory variable은 iteration 이전에 생성하고, 각 iteration 마다 random noise를 다르게 만들어 적합했다. 

4. paper에서는 두 가지 알고리즘을 비교하는데, 이 때 non-overlapping의 경우에는 NOL을 그렇지 않은 경우 F를 각 변수 뒤에 붙여주었다.

5. figure 4 하단부의 time에 관한 plot을 주목할 필요가 있다. 다른 plot과는 달리 이 부분만 paper와 다르게 plug-in의 time이 이차식의 형태로 구현되어있다. 이는 분산 추정량이 아래와 같이
<p align="center">
<a href="https://www.codecogs.com/eqnedit.php?latex=\hat&space;\Sigma&space;=&space;\hat&space;A^{-1}&space;\hat&space;S&space;\hat&space;A^{-1}&space;=&space;\frac{1}{n}&space;\sum_i&space;^n&space;\epsilon_i^2" target="_blank"><img src="https://latex.codecogs.com/svg.latex?\hat&space;\Sigma&space;=&space;\hat&space;A^{-1}&space;\hat&space;S&space;\hat&space;A^{-1}&space;=&space;\frac{1}{n}&space;\sum_i&space;^n&space;\epsilon_i^2" title="\hat \Sigma = \hat A^{-1} \hat S \hat A^{-1} = \frac{1}{n} \sum_i ^n \epsilon_i^2" /></a>    이므로 코드상에서 이를 재현한 결과이다. 


<변수 check>

xn : 모수

am : 블록을 결정하는 sequence

l : 블록 성분 개수

w : 블록 성분 합

