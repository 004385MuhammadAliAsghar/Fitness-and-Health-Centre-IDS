SELECT m.member_id, p.name, mp.plan_name, mp.fee
FROM member m
JOIN person p ON m.person_id = p.person_id
JOIN membership_plan mp ON m.plan_id = mp.plan_id

SELECT t.trainer_id, p.name, ws.session_name, ws.session_date
FROM trainer t
JOIN person p ON t.person_id = p.person_id
JOIN workout_session ws ON t.trainer_id = ws.trainer_id

SELECT p.name, ws.session_name, a.status
FROM attendance a
JOIN member m ON a.member_id = m.member_id
JOIN person p ON m.person_id = p.person_id
JOIN workout_session ws ON a.session_id = ws.session_id

SELECT plan_id, COUNT(*) AS total_members
FROM member
GROUP BY plan_id

SELECT plan_id, COUNT(*) AS total_members
FROM member
GROUP BY plan_id
HAVING COUNT(*) >= 1

SELECT member_id, amount
FROM invoice
WHERE amount > (SELECT AVG(amount) FROM invoice)

SELECT member_id
FROM member
WHERE member_id IN (SELECT member_id FROM attendance)

SELECT e.name, se.quantity
FROM equipment e
JOIN session_equipment se ON e.equipment_id = se.equipment_id

SELECT m.member_id, p.name
FROM premium_member pm
JOIN member m ON pm.member_id = m.member_id
JOIN person p ON m.person_id = p.person_id

SELECT m.member_id, f.comments, f.feedback_date
FROM feedback f
JOIN member m ON f.member_id = m.member_id

VIEW

CREATE VIEW MEMBER_VIEW AS
SELECT m.member_id, p.name, m.email, mp.plan_name, mp.fee
FROM member m
JOIN person p ON m.person_id = p.person_id
JOIN membership_plan mp ON m.plan_id = mp.plan_id

SELECT * FROM MEMBER_VIEW

TRIGGER (prevents negative invoice)

CREATE OR REPLACE TRIGGER CHECK_INVOICE_AMOUNT
BEFORE INSERT OR UPDATE ON INVOICE
FOR EACH ROW
BEGIN
    IF :NEW.amount < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Amount cannot be negative');
    END IF;
END;
/

