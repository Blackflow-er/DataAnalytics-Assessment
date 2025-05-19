SELECT 
	 u.id AS owner_id,
     u.name, 
     s.savings_count,
     i.investment_count,
     COALESCE(SUM(s.total_savings), 0) + COALESCE(i.total_investments, 0) AS total_deposits
FROM 
     users_customuser u
JOIN (
     SELECT
	     owner_id,
         COUNT(*) AS savings_count,
         SUM(new_balance) AS total_savings
	FROM
        savings_savingsaccount
	WHERE 
        transaction_status IN ('Success', 'Sucessful', 'Monthly_success') 
    GROUP BY 
        owner_id
) s ON u.id = s.owner_id
JOIN (
     SELECT 
         owner_id,
         COUNT(*) AS investment_count,
         SUM(amount) AS total_investments
	FROM
	    plans_plan 
	WHERE 
        interest_rate > 0
	GROUP BY 
		owner_id
) i ON u.id = i.owner_id 
GROUP BY 
    u.id, u.name, 
    s.savings_count, i.investment_count, s.total_savings, i.total_investments 
ORDER BY 
	total_deposits DESC
LIMIT 50;
    
    DESCRIBE plans_plan;
    DESCRIBE savings_savingsaccount;
    DESCRIBE users_customuser;