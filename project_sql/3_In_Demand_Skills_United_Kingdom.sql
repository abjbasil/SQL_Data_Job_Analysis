SELECT
    skills,
COUNT (skills_job_dim.job_id) AS in_demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id 
WHERE job_title_short = 'Data Analyst' AND
job_country = 'United Kingdom'
GROUP BY 
    skills
ORDER BY in_demand_count DESC
LIMIT 10

/* The most in-demand skills for data analysis in the UK are SQL, Excel, and Power BI, indicating a strong preference for tools that facilitate data manipulation, visualization, and business intelligence. These skills are followed by programming languages like Python and R, which are crucial for advanced data analysis and statistical modeling. The demand for these skills suggests that employers in the UK are looking for professionals who can not only analyse data but also present their findings effectively using various tools and technologies.*/