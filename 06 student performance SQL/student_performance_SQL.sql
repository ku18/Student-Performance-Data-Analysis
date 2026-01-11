CREATE DATABASE student_performance;
USE student_performance;

-- --------------------------------------- Data_Sanity_Check -------------------------------------------------------
SELECT *
FROM student_performance;

-- Number of rows
SELECT COUNT(*) AS total_rows
FROM student_performance;
-- there are 25000 rows

-- column names
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'student_performance';
-- columns are student_id, age, gender, school_type, parent_education, study_hours, attendance_percentage, internet_access, travel_time, extra_activities, study_method, math_score, science_score, english_score, overall_score, Final_grade

-- number of columns
SELECT COUNT(DISTINCT column_name)
FROM information_schema.columns
WHERE table_name = 'student_performance';
-- there are 16 columns

-- Data type

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'student_performance';


-- NULL SNAPSHOTS

SELECT 
SUM(
CASE
	WHEN student_id is NULL 
    THEN 1 
    ELSE 0
END
) AS null_count
FROM student_performance;

-- For single Row

SELECT COUNT(*)
FROM student_performance
WHERE student_id IS NULL
   OR TRIM(student_id) = '';

-- There are no null values

-- Check sample rows
SELECT *
FROM student_performance
LIMIT 5;


-- _____________________________________________ HANDLING DUPLICATES_____________________________________________

-- Idetifying Overall Duplicates using window functions
SELECT *,
ROW_NUMBER() OVER(PARTITION BY student_id, age, gender, school_type, parent_education, study_hours, attendance_percentage, internet_access, travel_time, extra_activities, study_method, math_score, english_score, overall_score, final_grade)
AS duped_count
FROM student_performance;

-- viewing ony duplicates using CTEs

WITH duplicated_CTE AS
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY student_id, age, gender, school_type, parent_education, study_hours, attendance_percentage, internet_access, travel_time, extra_activities, study_method, math_score, english_score, overall_score, final_grade)
AS duped_count
FROM student_performance
) 
SELECT *
FROM duplicated_CTE
WHERE duped_count > 1;
-- There are 10000 duplicated rows

-- Creating new table to store de duplicated rows

CREATE TABLE `deduped` (
  `student_id` int DEFAULT NULL,
  `age` int DEFAULT NULL,
  `gender` text,
  `school_type` text,
  `parent_education` text,
  `study_hours` double DEFAULT NULL,
  `attendance_percentage` double DEFAULT NULL,
  `internet_access` text,
  `travel_time` text,
  `extra_activities` text,
  `study_method` text,
  `math_score` double DEFAULT NULL,
  `science_score` double DEFAULT NULL,
  `english_score` double DEFAULT NULL,
  `overall_score` double DEFAULT NULL,
  `final_grade` text,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Insert values along with row num in it

INSERT INTO deduped
SELECT *,
ROW_NUMBER() OVER(PARTITION BY student_id, age, gender, school_type, parent_education, study_hours, attendance_percentage, internet_access, travel_time, extra_activities, study_method, math_score, english_score, overall_score, final_grade)
FROM student_performance;

SELECT *
FROM deduped;

-- checking no. of duplicate rows
SELECT COUNT(*)
FROM deduped
WHERE row_num>1;

-- removing overall duplicates
SET SQL_SAFE_UPDATES = 0;  

DELETE 
FROM deduped
WHERE row_num > 1;

-- 10000 rows are now deleted

-- dropping row_num column now from deduped
ALTER TABLE deduped
DROP COLUMN row_num;
 

-- Identifying duplicates in client_id as it is primary key


SELECT *,
ROW_NUMBER()OVER(PARTITION BY student_id)
FROM deduped;

WITH duplicated_sid AS
(
SELECT *,
ROW_NUMBER()OVER(PARTITION BY student_id) AS RN
FROM deduped
)
SELECT *
FROM duplicated_sid
WHERE RN > 1;

-- there are no duplicate client ids


-- ________________________________________DATA STANDARDIZATION _________________________________________________________


SELECT *
FROM deduped;

-- capitalize final grade

UPDATE deduped
SET final_grade = UPPER(final_grade);

SELECT *
FROM deduped;


-- _________________________________  Exploratory Data Analysis  ____________________________________________________

-- Identify variable types

DESCRIBE deduped; 

-- Central Tendency

SELECT 
AVG(overall_score) AS meani,
MIN(overall_score) AS mini,
MAX(overall_score) AS maxi
FROM deduped;

-- Central Tendency

SELECT
STDDEV(overall_score) AS std,
VARIANCE(overall_score) AS VAR
FROM deduped;

-- distribtuion shape
SELECT *
FROM deduped
WHERE overall_score > 
(
SELECT AVG(overall_score) + 3*stddev(overall_score)
FROM deduped
)
;


