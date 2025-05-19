DESCRIBE savings_savingsaccount;
  SELECT 
     frequency_category,
     COUNT(*) AS customer_count,
	 ROUND(AVG(avg_transactions_per_month), 2) AS avg_transactions_per_month
  FROM(
       SELECT
          u.id AS customer_id,
          u.name,
          COUNT(s.id) AS total_transactions,
          TIMESTAMPDIFF(MONTH, MIN(s.created_on), MAX(s.created_on)) + 1 AS active_months,
          ROUND(COUNT(s.id) / (TIMESTAMPDIFF(MONTH, MIN(s.created_on), MAX(s.created_on)) + 1), 2) AS avg_transactions_per_month,
	 	  CASE
             WHEN ROUND(COUNT(s.id) / (TIMESTAMPDIFF(MONTH, MIN(s.created_on), MAX(s.created_on)) + 1), 2) >= 10 THEN 'High Frequency'
             WHEN ROUND(COUNT(s.id) / (TIMESTAMPDIFF(MONTH, MIN(s.created_on), MAX(s.created_on)) + 1), 2) BETWEEN 3 AND 9 THEN 'Medium Frequency'
             ELSE 'Low Frequency'
		  END AS frequency_category
       FROM
           users_customuser u
	  JOIN 
           savings_savingsaccount s ON u.id = s.owner_id
	 WHERE
          s.transaction_status IN ('Success', 'Successful', 'Monthly-success')
	GROUP BY 
		  u.id, u.name
) AS sub
	GROUP BY
          frequency_category
    ORDER BY 
        CASE
           WHEN frequency_category = 'High Frequency' THEN 1
           WHEN frequency_category = 'Medium Frequency' THEN 2
           WHEN frequency_category = 'Low Frequency' THEN 3
		END;