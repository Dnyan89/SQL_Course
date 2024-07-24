/*Top in demand skills for data analysts
- Identify the top 5 in demand skills for the role of Data Analyst
- Find it for all the job postings
Why? To retrieve the in demand skills in the job market for data analysts, so as 
to provide the insghits on the valuable skills.
*/


SELECT
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM
    job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    skills_dim.skills
ORDER BY
    demand_count DESC
LIMIT 5;