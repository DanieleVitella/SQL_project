# Introduction
Explore the dynamic data job market with a focus on data scientist roles! This project delves into the highest-paying positions, essential skills in demand, and the sweet spots where top talent meets top salaries in data analytics.

SQL queries? Check them out here: [project_sql folder](/project_sql/)

# Background
### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data scientist jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data scientists?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
**Key Tools:**

- SQL
- PostgreSQL
- Visual Studio Code
- Git & GitHub

# The Analysis
Each query for this project aimed at investigating specific aspects of Data Science job market. 
Here's how I approached each question:

### 1. Top Paying Data Scientist Jobs
To identify the highest-paying roles, I filtered data scientist positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT
    job_id,
    job_title,
    name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact 
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id

WHERE
    job_title_short = 'Data Scientist' AND 
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10
```
| job_id  | job_title                                       | company_name          | job_location | job_schedule_type | salary_year_avg | job_posted_date       |
|---------|-------------------------------------------------|-----------------------|--------------|-------------------|-----------------|-----------------------|
| 40145   | Staff Data Scientist/Quant Researcher           | Selby Jennings        | Anywhere     | Full-time         | 550000.0        | 2023-08-16 16:05:16   |
| 1714768 | Staff Data Scientist - Business Analytics       | Selby Jennings        | Anywhere     | Full-time         | 525000.0        | 2023-09-01 19:24:02   |
| 1131472 | Data Scientist                                  | Algo Capital Group    | Anywhere     | Full-time         | 375000.0        | 2023-07-31 14:05:21   |
| 1742633 | Head of Data Science                            | Demandbase            | Anywhere     | Full-time         | 351500.0        | 2023-07-12 03:07:31   |
| 551497  | Head of Data Science                            | Demandbase            | Anywhere     | Full-time         | 324000.0        | 2023-05-26 22:04:44   |
| 126218  | Director Level - Product Management - Data Science | Teramind          | Anywhere     | Full-time         | 320000.0        | 2023-03-26 23:46:39   |
| 1161630 | Director of Data Science & Analytics            | Reddit                | Anywhere     | Full-time         | 313000.0        | 2023-08-23 22:03:48   |
| 457991  | Head of Battery Data Science                    | Lawrence Harvey       | Anywhere     | Full-time         | 300000.0        | 2023-10-02 16:40:07   |
| 226011  | Distinguished Data Scientist                    | Walmart               | Anywhere     | Full-time         | 300000.0        | 2023-08-06 11:00:43   |
| 129924  | Director of Data Science                        | Storm4                | Anywhere     | Full-time         | 300000.0        | 2023-01-21 11:09:36   |


Here's the breakdown of the top data scientist jobs in 2023:
- **Wide Salary Range:** Top 10 paying data analyst roles span from $300,000 to $550,000, indicating significant salary potential in the field.
- **Diverse Employers:** Companies like Selby Jennings, Walmart, and Reddit are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in job titles, from Staff Data Scientist to Product Data Scientist, reflecting varied roles and specializations within data analytics.

### 2. Skills for Top Paying Jobs

To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        name AS company_name,
        salary_year_avg
    FROM
        job_postings_fact 
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id

    WHERE
        job_title_short = 'Data Scientist' AND 
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON  skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC
```
Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:

- SQL and Python are the leaders.
- Java is also highly sought after. 
- Other skills like AWS, Spark, and TensorFlow show varying degrees of demand.

### 3. In-Demand Skills for Data Scientists
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON  skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Scientist' AND
    job_work_from_home = TRUE
GROUP BY 
    skills
ORDER BY 
    demand_count DESC
LIMIT 5

```
Here's the breakdown of the most demanded skills for data scientists in 2023:
- Python
- SQL
- R
- AWS
- Tableau

| skills   | demand_count |
|----------|--------------|
| python   | 10390        |
| sql      | 7488         |
| r        | 4674         |
| aws      | 2593         |
| tableau  | 2458         |

Python and SQL emerge as the top skills in demand, highlighting their importance in data-driven industries and software development. R, AWS, and Tableau also demonstrate significant demand, catering to specific niches such as statistical analysis, cloud computing, and data visualization. Professionals looking to enhance their marketability in these fields should consider acquiring or further developing these skills based on industry trends and job market demands.

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON  skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Scientist' 
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY 
    skills
ORDER BY 
    avg_salary DESC
LIMIT 25
```
**Top Skills Based on Salary:**

- GDPR: $217,738
- Golang: $208,750
- Atlassian: $189,700
- Selenium: $180,000
- OpenCV: $172,500

**Insights on Salary Trends:**

- **High Variability:** Salaries range significantly across different skills, from $217,738 for GDPR down to $157,244 for Julia. This variability suggests that the choice of skills can strongly influence earning potential.

- **Specialized Skills:** Skills like GDPR (General Data Protection Regulation), Golang (Go programming language), and Atlassian tools command higher salaries, likely due to their specialized nature and demand in specific industries or sectors.

- **Technological Tools:** Skills such as Selenium, OpenCV, and MicroStrategy also show strong average salaries, indicating the value placed on expertise in automation testing, computer vision, and business intelligence tools in Data Science roles.

### 5. Most Optimal Skills to Learn
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
SELECT  
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = true
GROUP BY 
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) >10
ORDER BY 
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
| skill_id | skills        | demand_count | avg_salary |
|----------|---------------|--------------|------------|
| 26       | c             | 48           | 164865     |
| 8        | go            | 57           | 164691     |
| 187      | qlik          | 15           | 164485     |
| 185      | looker        | 57           | 158715     |
| 96       | airflow       | 23           | 157414     |
| 77       | bigquery      | 36           | 157142     |
| 3        | scala         | 56           | 156702     |
| 81       | gcp           | 59           | 155811     |
| 80       | snowflake     | 72           | 152687     |
| 101      | pytorch       | 115          | 152603     |
| 78       | redshift      | 36           | 151708     |
| 99       | tensorflow    | 126          | 151536     |
| 233      | jira          | 22           | 151165     |
| 92       | spark         | 149          | 150188     |
| 76       | aws           | 217          | 149630     |
| 94       | numpy         | 73           | 149089     |
| 106      | scikit-learn  | 81           | 148964     |
| 95       | pyspark       | 34           | 147544     |
| 182      | tableau       | 219          | 146970     |
| 2        | nosql         | 31           | 146110     |
| 4        | java          | 64           | 145706     |
| 196      | powerpoint    | 23           | 145139     |
| 93       | pandas        | 113          | 144816     |
| 213      | kubernetes    | 25           | 144498     |
| 1        | python        | 763          | 143828     |


**Strategic Insights for Skill Development:**


The data highlights Python, TensorFlow, Spark, AWS, and Tableau as optimal skills for data scientists seeking high-demand and high-paying positions. These skills not only offer job security due to their market demand but also provide financial benefits with competitive average salaries. Continuous learning and proficiency in these technologies can strategically advance a career in data science, aligning with industry trends and job market demands.

# Key Insights from Data Scientist Job Market Analysis

1. **Top-Paying Data Scientist Jobs (2023):**

- Identified roles span a wide salary range from $300,000 to $550,000 annually.
- Diverse employers such as Selby Jennings, Walmart, and Reddit offer high salaries, indicating broad industry interest.
- Job titles vary significantly, reflecting diverse roles and specializations within data analytics.

2. **Skills for Top-Paying Jobs:**

- SQL and Python are consistently top skills sought after for high-paying data scientist positions.
- Java, AWS, Spark, and TensorFlow also demonstrate - significant demand, showcasing a diverse skill set required in top-tier roles.

3. **In-Demand Skills for Data Scientists (2023):**

- Python leads in demand, followed by SQL, R, AWS, and Tableau, emphasizing their critical roles across various data-driven industries.
- These skills are essential for roles in data analysis, machine learning, and cloud computing, highlighting their broad applicability.

4. **Skills Based on Salary:**

- Identified top-paying skills include GDPR, Golang, Atlassian, Selenium, and OpenCV, with salaries ranging notably based on specialized expertise.
- Specialized skills command higher salaries due to their niche demand and critical role in specific sectors like data protection, programming, and analytics.

5. **Most Optimal Skills to Learn:**

- Python and TensorFlow stand out as optimal skills due to their high demand and competitive salaries, ensuring job security and financial rewards.
- AWS, Spark, and Tableau are also recommended for their significant roles in cloud computing, big data processing, and data visualization.


6. **Strategic Insights for Skill Development:**

- Continuous learning and proficiency in emerging technologies such as AI frameworks (e.g., TensorFlow) and cloud platforms (e.g., AWS) are crucial for career advancement in data science.
- Mastery of visualization tools like Tableau enhances the ability to derive actionable insights, supporting decision-making processes in organizations.


# Conclusions
This project enhanced my SQL skills and provided valuable insights into the data scientist job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data scientists can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.