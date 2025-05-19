DESCRIBE savings_savingsaccount;
DESCRIBE plans_plan;
SELECT
     sa.id AS plan_id, 
     sa.owner_id,
     'Savings' AS type, 
     sa.created_on AS last_transaction_date,
     DATEDIFF(CURRENT_DATE, sa.created_on) AS inactivity_days
FROM savings_savingsaccount sa 
WHERE DATEDIFF(CURRENT_DATE, sa.created_on) > 365

UNION

SELECT 
     pp.id AS plan_id,
     pp.owner_id,
     'Investment' AS type,
     pp.created_on AS last_transaction_date,
     DATEDIFF(CURRENT_DATE, pp.created_on) AS inactivity_days
FROM plans_plan pp
WHERE DATEDIFF(CURRENT_DATE, pp.created_on) > 365;