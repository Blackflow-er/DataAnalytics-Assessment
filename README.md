# DataAnalytics-Assessment

### Q1: HIGH-VALUE CUSTOMERS WITH MULTIPLE PRODUCTS ANALYSIS 

Title: High-Value Customers with Multiple Products

### OBJECTIVE 
To identify high-value customers who have both a funded savings
account and an investment plan, in order to uncover cross-selling 
opportunities.

### APPROACH 
	1.	Data Extraction:
	•	The dataset was provided as a MySQL dump 
            (adashi_assessment.sql).
    •	Tables involved: users_customuser, savings_savingsaccount, and 
            plans_plan.
	2.	Schema Understanding:
	•	Analyzed the structure of each table to understand relationships.
	•	Identified:
	•	owner_id as the foreign key linking users to savings and plans.
	•	transaction_status in savings_savingsaccount to evaluate savings 
            activity.
	•	interest_rate in plans_plan to infer investment plans.
	3.	Business Logic:
	•	Customers with at least one savings account with a successful 
            transaction status.
	•	Customers with at least one investment plan (determined by 
            interest_rate > 0).
	•	Aggregated total deposits using new_balance from savings and 
            amount from plans.
	4.	SQL Query Development:
	•	Wrote SQL joins and applied filters to meet the logic above.
	•	Used GROUP BY, HAVING, and ORDER BY to generate final insights.

 ### TABLE OUTPUT 
 


   ### CHALLENGES FACED
    1.	Non-Standard Status Values:
	 •	The transaction_status column in savings_savingsaccount had many 
            custom and inconsistent status messages (e.g., “Charge attempt 
            cannot be fulfilled…”, “Successful”, “Abandoned”).
	 •	Solution: Created a whitelist of known success indicators ('Success', 
            'Successful', 'Monthly_success') to filter valid transactions.
	 2.	Missing/Unclear Fields:
	 •	There was no direct type field in plans_plan to distinguish investment 
            plans.
	 •	Solution: Used interest_rate > 0 as a proxy to identify 
            investment-related entries.
	 3.	Data Quality Issues:
	 •	Some entries had missing or ambiguous information.
	 •	Addressed this by using COALESCE () to handle NULL values in   
            calculations.
	 4.	Query Returns Empty Result:
	 •	Initially, the query returned no rows due to loose filtering criteria.
	 •	Fixed by tightening filter logic and testing subqueries independently.




