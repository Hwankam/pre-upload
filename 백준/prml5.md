# 6.4.2

Gaussian process 문제를 regression setting에 적용하기 위해서는 noise 개념을 도입해야 한다. 

$$
t_n = y(x_n) + \epsilon_n
$$

Gaussian 분포를 갖는 noise process를 생각하면 

$$
p(t_n | y_n ) = \mathcal{N}(t_n | y(x_n), \beta ^{-1} )
$$

noise는 모두 독립이므로, $y(x_n)$의 값이 모두 조건으로 주어졌을 때 target value t에 대한 joint distribution은

$$
p(\boldsymbol{t} | \boldsymbol{y} ) = \mathcal{N}(\boldsymbol{t} | \boldsymbol{y}, \beta ^{-1} \boldsymbol{I}_N )
$$

그리고 $\boldsymbol{y}$가 Gaussian Process 를 따른다고하면 정의에 의해 marginal distribution 또한 Gaussian을 따른다.

$$
p(\boldsymbol{y}) = \mathcal{N}(\boldsymbol{y} | 0, \boldsymbol{K})
$$

여기서 K는 gram matrix이며 이는 각 원소가 kernel의 내적으로 정의된 함수이다. 

이때 t에 대한 marginal distribution을 구하면 

$$
p(\boldsymbol{t}) = \int p(\boldsymbol{t}|\boldsymbol{y}) p(\boldsymbol{y}) d\boldsymbol{y} = \mathcal{N} ( \boldsymbol{t} | 0, \boldsymbol{C} )
$$

Gaussian process regression에서 가장 자주 쓰이는 kernel function은 exponential of quadratic form으로 아래와 같다.

$$
k(x_n, x_m) = \theta_0 exp \{ - \frac{\theta_1}{2} ||x_n - x_m || ^2\} + \theta_2 + \theta_3 x_n^Tx_m
$$

여기서 주목할 만한 점은 linear term이 input variable x에 대한 linear function이라는 것이다.

이제 regression에 초점을 맞춰보자. 결국 하고 싶은 것은 prediction이므로 new input $x_{N+1}$에 대한 target 
$t_{N+1}$ 을 예측하고 싶다. 즉 
$p(t_{N+1} | \boldsymbol{t}_N)$ 을 구하고 싶다. 

N+1개의 target에 대한 joint distribution은 위에서 구한 marginal distribution을 활용해서 아래 결과를 알 수 있다.

$$
p(\boldsymbol{t}_{N+1}) = \mathcal{N} ( \boldsymbol{t}_{N+1} | 0, \boldsymbol{C}_{N+1} )
$$

이때 $\boldsymbol{C}_{N+1}$에 대한 partition matrix를 다음과 같이 정의한다고 하자.

$$


C=
(
\begin{array}{c c}
\boldsymbol{C}_N & k \\

k^T & c
\end{array}

)
$$

이 때의 predictive distribution의 평균과 분산은 아래와 같다.

$$
\begin{align}
& m(x_{N+1}) = k^T \boldsymbol{C}_N ^{-1} \boldsymbol{t} \\
& \sigma^2(x_{N+1}) = c - k^T\boldsymbol{C}_N ^{-1} k
\end{align}
$$


식에서도 알 수 있듯, predictive distribution은 Gaussian이며 평균과 분산이 new input value $x_{N+1}$ 에 의존한다. (또한 kernel에 의존한다) 그래서 kernel
$k(x,x')$만 잘 정의된다면 3.3.2장에서 배운 linear regression의 predictive distribution에 대한 gaussian process 관점을 살펴볼 수 있게 되는 것이다. 

정리하면 predictive distribution에 대한 두가지 관점이 존재한다. 

1. linear regression을 사용한 parameter space viewpoint

    $y = X \beta + \epsilon $ 에서 
    $\beta$의 추정이 중요한 경우

2. Gaussian process를 활용한 function space viewpoint

    $y = f(x_n) + \epsilon$ 에서 GP
    $f(x_n)$이 중요한 경우


이제 Gaussian process의 한계를 살펴보자. 우선 GP는 역행렬 계산이 들어가기 때문에 연산량이 매우 크다 -- $O(N^3)$

만약 basis function에 의해 x의 공간이 확장(?)되면 연산량은 기하급수적으로 늘어날 것이다. 그럼에도 불구하고 GP를 사용하면 공분산함수를 basis function을 활용해 나타낼 수 있다는 장점이 있다.