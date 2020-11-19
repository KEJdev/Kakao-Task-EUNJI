SELECT * from a_payment;
SELECT * from dutchpay;

-- 1. 더치페이를 요청한 유저
create view dutchpay_claim
as
SELECT claim_user_id
from dutchpay;
where claim_at between to_date('19/12/01', 'RR/MM/DD') and to_date('19/12/31', 'RR/MM/DD');

--2. a 가맹점에서 2019년 12월에 1만원 이상 결제한 유저들
create view payment
as
SELECT user_id, id, transacted_at, amount, payment_action_type
from a_payment
where transacted_at between to_date('19/12/01', 'RR/MM/DD') and to_date('19/12/31', 'RR/MM/DD') and amount>=10000 ;

--3. 12월에서 2월 사이에 결제를 취소한 사람들
create view cancel_user
as
select user_id,id,  amount, payment_action_type
from a_payment
where transacted_at between to_date('19/12/01', 'RR/MM/DD') and to_date('20/02/29', 'RR/MM/DD') and payment_action_type = 'CANCEL';

--3. 취소 반영한 순결제금액 1만원 이상인 유저들
create view payment_user
as
select user_id, id, transacted_at, amount, payment_action_type
from payment
where id in (select id from payment
minus
select id from cancel_user);

--4. 더치페이를 요청한 유저 중 a가맹점에서 2019년 12월에 1만원 이상 결제한 유저
SELECT user_id from payment_user
intersect
SELECT claim_user_id from dutchpay;
