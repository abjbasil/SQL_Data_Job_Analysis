WITH top_paying_jobs AS (
SELECT 
job_id,
job_title_short,
name AS company_name,
salary_year_avg
FROM job_postings_fact
LEFT JOIN company_dim ON
job_postings_fact.company_id = company_dim.company_id
WHERE 
job_title_short = 'Data Analyst' AND
salary_year_avg IS NOT NULL AND
job_location ='Anywhere'
ORDER BY salary_year_avg DESC
LIMIT 10
)
SELECT 
top_paying_jobs.*,
skills
FROM top_paying_jobs
 INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
 INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
 ORDER BY salary_year_avg DESC

 /* Based on job postings, the following is a breakdown of the most in-demand competencies for data analysts in 2023:
• With a bold count of eight, SQL is in the lead.
• With a bold count of 7, Python comes in second.
• With a bold count of six, Tableau is also very popular.
• The demand for other skills, including as R, Snowflake, Pandas, and Excel, varies.*/