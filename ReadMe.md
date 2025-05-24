# Introduction - 
Welcome to my first SQL project, focusing on the UK data analysis job market. This project utilises database manipulation to identify top-paying job roles, the skills associated with them, and overall in-demand skills within the sector.

SQL queries? Check them out here: [project_sql](/project_sql/)

# Questions -
1) What are the top-paying data analyst jobs?
2) What are the skills required for the jobs mentioned in question 1?
3) What skills are most in-demand for data-analysts?
4) Which skills are associated with higher salaries? 

# Programmes I Used -
**SQL:**  SQL was used in this project as it allows for efficient data manipulation and querying, enabling the extraction of insights from large datasets.

**Postgresql:** The chosen database system. Its ability to handle large volumes of data and support for complex queries makes it an ideal choice for analysing the job market data.

**Visual Studio Code:** A lightweight versatile code editor which supports a wide range of programming languages. Its extensions, such as the PostgreSQL extension, enabled efficient database management and querying directly within the editor.

**Github:** The use of GitHub enabled me to track changes made to the SQL queries and database schema, ensuring transparency and reproducibility in my analysis.

# The Analysis -
Every question in this project was designed to look into a different facet of the data industry market. 
### 1 - Top Paying Data Analyst Jobs in the UK
To identify highest paying roles, I filtered data analyst positions, specifically those located in the United Kingdom, by their average annual salary and then ordered them in descending order.

```sql
SELECT 
job_id,
job_title_short,
name AS company_name,
job_schedule_type,
job_location,
salary_year_avg
FROM job_postings_fact
LEFT JOIN company_dim ON
job_postings_fact.company_id = company_dim.company_id
WHERE 
job_title_short = 'Data Analyst' AND
salary_year_avg IS NOT NULL AND
job_location ='United Kingdom'
ORDER BY salary_year_avg DESC
```
Here is the breakdown of the top data analyst jobs within the UK for 2023:

**Diverse Industry Representation** - 
Employers span banking (Deutsche Bank), energy (Shell), toys (Hasbro), luxury retail (CHANEL), pharma/agriculture (Syngenta), alcoholic beverages (Campari Group), and non-profits (Catch22) — showing data roles are essential across all sectors.

**Job Schedule Uniformity-**
Nearly all roles are full-time, showing that the data analyst function is considered core, not peripheral. Only 2 out of 21 roles include part-time or temporary flexibility.

## 2) What are the skills required for the jobs mentioned in question 1? 
To identify skills related to the top paid data analyst positions within the UK, I had joined the job postings fact table with the skills data table to gain further insight.
```sql
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
 ```
 Here is a breakdown of the skills related to the top paying data analyst jobs within UK:

  **Highly Recurrent Skills with Strong Salary Correlation**

SQL:
Appears across nearly every job; associated with £184K–£255K, showing it’s a must-have core skill.

Python:
Found in most top-paying jobs. Strong correlation with higher pay, especially when combined with cloud or ML tools.

**Skill Combinations that Boost Pay**

Cloud + Python + BI Tools:
Example: AT&T role using AWS, Python, Power BI, SQL – paid £255K.

Statistical Tools + Data Engineering:
R, Databricks, Hadoop, Snowflake – blend analysis with big data pipeline skills.

**Key Takeaways**

Mastering Python + SQL + BI tools is foundational.
Adding cloud tech (AWS, Azure, Snowflake) significantly raises salary potential.
Candidates skilled in both data analysis and engineering platforms command top-tier salaries.

## 3) What skills are most in-demand for data-analysts?

The process involved creating a query to count and rank skills by frequency, thereby providing insight into the most prevalent skills mentioned in job descriptions among the United Kingdom.

```sql 
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
```
Below is a breakdown of the skills:

SQL and Excel remain the most in-demand skills, with over 4,000 mentions each, showing that core data tools are still essential for data analysis roles.

Power BI is more frequently requested than Tableau, with nearly 75% more mentions, suggesting a stronger preference for Microsoft's business intelligence tools in the job market.

Skills like Python, Azure, and Go are appearing more often, indicating that data analysts are increasingly expected to have programming and cloud platform experience.

| **Skill**  | **In-Demand Count** |
| ---------- | ------------------- |
| SQL        | 4,480               |
| Excel      | 4,281               |
| Power BI   | 2,865               |
| Python     | 2,129               |
| Tableau    | 1,644               |
| R          | 1,100               |
| SAS        | 738                 |
| Azure      | 680                 |
| Go         | 548                 |
| PowerPoint | 527                 |


## 4) Which skills are associated with higher salaries?

Taking a further look at higher salaries and then pairing it will skills let me know which would be optimal to learn.

```sql
SELECT
    skills,
    ROUND(AVG(salary_year_avg),2) AS yearly_average
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id 
WHERE job_title_short = 'Data Analyst' AND
salary_year_avg IS NOT NULL AND
job_location = 'United Kingdom'
GROUP BY 
    skills
ORDER BY yearly_average DESC
```
Below is a breakdown of the results:

**Top Insights**

Highest-paying skills:
🥇 Shell & Flow – £156,500
🥈 Looker – £118,140
🥉 SAS – £109,000

**Popular analytics tools with lower averages:**

SQL – only £65,818 despite its high demand

Power BI – £74,563

Excel – £82,494

**Programming tools:**

Python (£83,968) outpaces R (£81,709) and Go (£77,635)
Jupyter, used with Python, stands at £103,620


# What I Learned -

Using advanced SQL techniques, I leveraged SELECT statements and a range of aggregate functions to extract meaningful insights from the data. By implementing various types of JOIN operations, I was able to integrate the datasets effectively, enabling a more comprehensive analysis of how skill sets correlate with job roles and compensation across different industries.

Throughout the project, I deepened my understanding of SQL's more advanced functionalities, including grouping, filtering, and aggregating data to uncover trends and patterns. This analytical process allowed me to not only manipulate the data to return targeted results but also to distill the findings into actionable insights that reflect the structure and demands of the UK data job market.




