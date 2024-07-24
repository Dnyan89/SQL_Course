/* Most optimal skills (high demand and paying skills)
- Identify the most high demanding and high paying skills for the role of Data Analyst
- Fin it for the remote positions and specific salary
Why? Aim for the skills in high demand and financially rewarding to develop
*/


WITH demand_skills AS (
        SELECT
            skills_dim.skill_id,
            skills_dim.skills,
            COUNT(skills_job_dim.job_id) AS demand_count
        FROM
            job_postings_fact
            INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
            INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
        WHERE
            job_title_short = 'Data Analyst' AND
            salary_year_avg IS NOT NULL AND
            job_work_from_home = True 
        GROUP BY
            skills_dim.skill_id
),
    average_salary AS (
        SELECT
            skills_job_dim.skill_id,
            ROUND(AVG(salary_year_avg), 0) AS avg_salary
        FROM
            job_postings_fact
            INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
            INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
        WHERE
            job_title_short = 'Data Analyst' AND
            salary_year_avg IS NOT NULL AND
            job_work_from_home = True     ---optional for remote jobs
        GROUP BY
            skills_job_dim.skill_id
)

SELECT
    demand_skills.skills,
    demand_skills.demand_count,
    average_salary.avg_salary
FROM
    demand_skills
    INNER JOIN average_salary ON demand_skills.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    demand_count DESC,
    avg_salary DESC;





----------Rewriting the same query more consily-----

SELECT
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = True
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT
    25;
    
