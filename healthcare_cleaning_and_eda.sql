-- =========================================================
-- Healthcare Dataset — SQL Cleaning & Exploratory Analysis
-- =========================================================

-- CLEANING (representative SQL, full logic in clean_pipeline.py)
-- 1. Remove exact duplicate admissions
DELETE FROM healthcare_raw
WHERE rowid NOT IN (
    SELECT MIN(rowid)
    FROM healthcare_raw
    GROUP BY patient_id, admission_date, discharge_date, cost
);

-- 2. Standardize gender values
UPDATE healthcare_raw
SET gender = CASE
    WHEN LOWER(gender) IN ('m','male') THEN 'M'
    WHEN LOWER(gender) IN ('f','female') THEN 'F'
    ELSE 'Unknown'
END;

-- 3. Flag invalid ages for correction
UPDATE healthcare_raw SET age = NULL WHERE age < 0;

-- 4. Fill missing categorical fields
UPDATE healthcare_raw SET diagnosis = 'Not Recorded' WHERE diagnosis IS NULL;
UPDATE healthcare_raw SET insurance_type = 'Unknown' WHERE insurance_type IS NULL;

-- =========================================================
-- EXPLORATORY DATA ANALYSIS (run on healthcare_clean)
-- =========================================================

-- 1. Total admissions, unique patients, average cost
SELECT
    COUNT(*) AS total_admissions,
    COUNT(DISTINCT patient_id) AS unique_patients,
    ROUND(AVG(cost), 2) AS avg_cost,
    ROUND(AVG(length_of_stay), 1) AS avg_length_of_stay
FROM healthcare_clean;

-- 2. Admissions and average cost by department
SELECT
    department,
    COUNT(*) AS admissions,
    ROUND(AVG(cost), 2) AS avg_cost,
    ROUND(SUM(cost), 2) AS total_cost
FROM healthcare_clean
GROUP BY department
ORDER BY total_cost DESC;

-- 3. Top 5 most common diagnoses
SELECT
    diagnosis,
    COUNT(*) AS cases
FROM healthcare_clean
WHERE diagnosis != 'Not Recorded'
GROUP BY diagnosis
ORDER BY cases DESC
LIMIT 5;

-- 4. Cost by insurance type
SELECT
    insurance_type,
    COUNT(*) AS admissions,
    ROUND(AVG(cost), 2) AS avg_cost
FROM healthcare_clean
GROUP BY insurance_type
ORDER BY avg_cost DESC;

-- 5. Age distribution by bracket
SELECT
    CASE
        WHEN age < 18 THEN 'Under 18'
        WHEN age BETWEEN 18 AND 40 THEN '18-40'
        WHEN age BETWEEN 41 AND 65 THEN '41-65'
        ELSE '65+'
    END AS age_bracket,
    COUNT(*) AS patients,
    ROUND(AVG(cost), 2) AS avg_cost
FROM healthcare_clean
GROUP BY age_bracket
ORDER BY patients DESC;

-- 6. Monthly admission trend
SELECT
    strftime('%Y-%m', admission_date) AS admission_month,
    COUNT(*) AS admissions
FROM healthcare_clean
GROUP BY admission_month
ORDER BY admission_month;
