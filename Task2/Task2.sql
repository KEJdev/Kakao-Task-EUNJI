SELECT * from a_payment;
SELECT * from dutchpay;

-- 1. ��ġ���̸� ��û�� ����
create view dutchpay_claim
as
SELECT claim_user_id
from dutchpay;
where claim_at between to_date('19/12/01', 'RR/MM/DD') and to_date('19/12/31', 'RR/MM/DD');

--2. a ���������� 2019�� 12���� 1���� �̻� ������ ������
create view payment
as
SELECT user_id, id, transacted_at, amount, payment_action_type
from a_payment
where transacted_at between to_date('19/12/01', 'RR/MM/DD') and to_date('19/12/31', 'RR/MM/DD') and amount>=10000 ;

--3. 12������ 2�� ���̿� ������ ����� �����
create view cancel_user
as
select user_id,id,  amount, payment_action_type
from a_payment
where transacted_at between to_date('19/12/01', 'RR/MM/DD') and to_date('20/02/29', 'RR/MM/DD') and payment_action_type = 'CANCEL';

--3. ��� �ݿ��� �������ݾ� 1���� �̻��� ������
create view payment_user
as
select user_id, id, transacted_at, amount, payment_action_type
from payment
where id in (select id from payment
minus
select id from cancel_user);

--4. ��ġ���̸� ��û�� ���� �� a���������� 2019�� 12���� 1���� �̻� ������ ����
SELECT user_id from payment_user
intersect
SELECT claim_user_id from dutchpay;
