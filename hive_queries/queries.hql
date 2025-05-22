
-- 1. Physical Activity by Education Level
SELECT Education, SUM(Data_Value * Sample_Size) / SUM(Sample_Size) AS weighted_avg_physical_activity
FROM omid_dataset
WHERE Class = 'Physical Activity' AND Data_Value IS NOT NULL
GROUP BY Education;

-- 2. Obesity Rates by Education Level
SELECT Education, Question, SUM(Data_Value * Sample_Size) / SUM(Sample_Size) AS weighted_avg_obesity_rate
FROM omid_dataset
WHERE Class = 'Obesity / Weight Status' AND Data_Value IS NOT NULL
GROUP BY Education, Question
ORDER BY Education, weighted_avg_obesity_rate DESC;

-- 3. Vegetable Intake by State and Education
SELECT LocationDesc, Education, SUM(Data_Value * Sample_Size) / SUM(Sample_Size) AS weighted_avg_low_veg_intake
FROM omid_dataset
WHERE Class = 'Fruits and Vegetables' AND Data_Value IS NOT NULL
GROUP BY LocationDesc, Education
ORDER BY LocationDesc, weighted_avg_low_veg_intake DESC;

-- 4. Trend: Physical Activity Over Time
SELECT YearStart, Education, SUM(Data_Value * Sample_Size) / SUM(Sample_Size) AS weighted_avg_physical_activity
FROM omid_dataset
WHERE Class = 'Physical Activity' AND Data_Value IS NOT NULL
GROUP BY YearStart, Education
ORDER BY YearStart, Education;

-- 5. Average Low Vegetable Intake by Education Level
SELECT Education, SUM(Data_Value * Sample_Size) / SUM(Sample_Size) AS weighted_avg_low_veg_intake
FROM omid_dataset
WHERE Class = 'Fruits and Vegetables' AND Data_Value IS NOT NULL
GROUP BY Education;
