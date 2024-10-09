---
title: RMSprop
---
### Root Mean Square Prop

$$
s_{dw}=\beta s_{dw}+(1-\beta)dw^2\\
s_{db}=\beta s_{db}+(1-\beta)db^2\\
w:=w-\alpha\frac{dw}{\sqrt{s_{dw}}}\\
b:=b-\alpha\frac{db}{\sqrt{s_{db}}}
$$

![](/assets/24257888-d68a-4aa3-a0aa-1fe7e45100cd.png)

- RMSprop 은 상대적으로 큰 $b$ 를 더 작게 업데이트 하고, 상대적으로 작은 $w$ 를 크게 업데이트 하므로써 경사 하강이 수평 방향으로 이루어지도록 돕는다.
- RMSprop 을 모멘텀과 함께 사용할 것이므로 아래처럼 $\beta_2$로 표기한다.

$$
s_{dw}=\beta_2 s_{dw}+(1-\beta_2)dw^2\\
$$

- 또한 제곱근이 0과 가까우면 값이 너무 커지기 때문에 분모에 작은 $\epsilon$ 을 추가한다.

$$
w:=w-\alpha\frac{dw}{\sqrt{s_{dw}+\epsilon}}
$$