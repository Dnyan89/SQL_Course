SELECT 
    COUNT(job_id) AS job_count,
    EXTRACT(MONTH FROM job_posted_date) AS job_posted_month
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    job_posted_month
ORDER BY
    job_count DESC;




SELECT
    job_schedule_type,
    AVG(salary_year_avg) AS average_yearly_salary,
    AVG(salary_hour_avg) AS average_hourly_salary
FROM
    job_postings_fact
WHERE
    job_posted_date::date > '2023-06-01'
GROUP BY
    job_schedule_type
ORDER BY
    job_schedule_type;




SELECT
    COUNT(job_id) AS jobs,
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS job_posted_month
FROM 
    job_postings_fact
GROUP BY
    job_posted_month
ORDER BY
    job_posted_month;



SELECT
    company_dim.name AS company_name,
    COUNT(job_postings_fact.job_id) AS job_count
FROM 
    job_postings_fact
    LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
WHERE
    job_postings_fact.job_health_insurance = 'TRUE'
    AND EXTRACT(QUARTER FROM job_postings_fact.job_posted_date) = 2
GROUP BY
    company_dim.name
HAVING 
    COUNT(job_postings_fact.job_id) > 0
ORDER BY
    job_count DESC;



SELECT*
FROM(
        SELECT *
        FROM
            job_postings_fact
        WHERE EXTRACT(MONTH FROM job_posted_date) = 2
    ) AS february_jobs;

SELECT *
FROM february_jobs;


WITH january_jobs AS ( -- CTE definition starts here
	  SELECT *
	  FROM job_postings_fact
	  WHERE EXTRACT(MONTH FROM job_posted_date) = 2
) -- CTE definition ends here

SELECT *
FROM january_jobs;