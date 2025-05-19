SELECT 
      u.id AS customer_id,
      CONCAT(u.first_name, ' ', u.last_name) AS name,
      TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE) AS tenure_months,
      COUNT(sa.id) AS total_transactions,
      ROUND(
            (COUNT(sa.id) * 12 * 0.001 * AVG(sa.amount))
            / GREATEST(TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE), 1),
            2
	 ) AS estimated_clv
FROM users_customuser u
JOIN savings_savingsaccount sa ON u.id = sa.owner_id
GROUP BY u.id, u.first_name, u.last_name, u.date_joined
ORDER BY estimated_clv DESC;