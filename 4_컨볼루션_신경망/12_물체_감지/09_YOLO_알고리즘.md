---
title: YOLO 알고리즘
---

$$
y\text{ is }\text{\#grid}\times\text{\#grid}\times\text{\#anchors}\times\text{\#classes}
$$

![](/assets/f240810c-3187-484c-9494-3046bf9699a8.png)

- 원본 이미지에서 ConvNet 을 지나 최종적으로 $y$ 가 나온 이후에 non-max 알고리즘을 실행한다.
    - 각 그리드 셀마다 2개의 예측된 경계 상자를 얻는다.
    - 낮은 확률의 예측은 제거한다.
    - 각 클래스(보행자, 자동차, 오토바이)에 대해 비최대 억제(Non-Max Suppression)를 사용하여 최종 예측을 생성한다.