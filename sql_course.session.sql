select *
from skills_job_dim
limit 100

select *
from skills_dim
limit 100
--------CTE
with skill_count_job as (
select skills_job_dim.skill_id,
count(*) as count_jobs

from job_postings_fact inner join skills_job_dim
on job_postings_fact.job_id = skills_job_dim.job_id

where 
    (job_postings_fact.job_work_from_home = true and 
    job_postings_fact.job_title_short = 'Data Analyst')
group by skill_id
limit 100
)

select skills_dim.skill_id, skills, count_jobs
from skills_dim inner join skill_count_job
on skills_dim.skill_id = skill_count_job.skill_id
order by count_jobs DESC

limit 5
----------
