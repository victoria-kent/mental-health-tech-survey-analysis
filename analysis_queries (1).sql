-- ============================================================
-- Mental Health in Tech Survey — SQL Analysis
-- Dataset: OSMI Mental Health in Tech Survey (2014), cleaned
-- ============================================================

-- 1. Overall treatment-seeking rate
SELECT
    treatment,
    COUNT(*) AS respondents,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM survey), 1) AS pct
FROM survey
GROUP BY treatment;

-- 2. Treatment-seeking rate by company size
SELECT
    no_employees AS company_size,
    COUNT(*) AS respondents,
    SUM(CASE WHEN treatment = 'Yes' THEN 1 ELSE 0 END) AS sought_treatment,
    ROUND(100.0 * SUM(CASE WHEN treatment = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS pct_treated
FROM survey
GROUP BY no_employees
ORDER BY pct_treated DESC;

-- 3. Does remote work correlate with treatment-seeking?
SELECT
    remote_work,
    COUNT(*) AS respondents,
    ROUND(100.0 * SUM(CASE WHEN treatment = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS pct_treated
FROM survey
GROUP BY remote_work;

-- 4. Availability of employer mental health benefits vs. treatment-seeking
SELECT
    benefits,
    COUNT(*) AS respondents,
    ROUND(100.0 * SUM(CASE WHEN treatment = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS pct_treated
FROM survey
GROUP BY benefits
ORDER BY pct_treated DESC;

-- 5. Family history of mental illness vs. treatment-seeking
SELECT
    family_history,
    COUNT(*) AS respondents,
    ROUND(100.0 * SUM(CASE WHEN treatment = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS pct_treated
FROM survey
GROUP BY family_history;

-- 6. Comfort discussing mental health with supervisor, by gender
SELECT
    Gender,
    supervisor,
    COUNT(*) AS respondents
FROM survey
GROUP BY Gender, supervisor
ORDER BY Gender, respondents DESC;

-- 7. Top 10 countries by respondent count, with average age and treatment rate
SELECT
    Country,
    COUNT(*) AS respondents,
    ROUND(AVG(Age), 1) AS avg_age,
    ROUND(100.0 * SUM(CASE WHEN treatment = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS pct_treated
FROM survey
GROUP BY Country
ORDER BY respondents DESC
LIMIT 10;

-- 8. Does perceived anonymity of mental health resources affect willingness to seek help?
SELECT
    anonymity,
    COUNT(*) AS respondents,
    ROUND(100.0 * SUM(CASE WHEN treatment = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 1) AS pct_treated
FROM survey
GROUP BY anonymity
ORDER BY pct_treated DESC;
