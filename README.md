# 과제 

------------

### Task 2

- 도커 이미지 오라클11g 사용. 
- SQL Developer 툴 사용.

조건에 맞게 테이블을 2개의 view로 생성 후 차집합 연산자를 사용하였다.  

**create view**  
1. payment : 2019년 12월에 1만원 이상 결제한 유저들
2. cancel_user : 12월에 결제를 했지만 12월에서 2월 사이에 취소한 사람들

**output**  
payment - cancel_user (차집합 연산)
