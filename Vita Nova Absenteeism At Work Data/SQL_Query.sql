
-- create a join table

SELECT 
  * 
FROM 
  [dbo].[Absenteeism_At_Work] a 
  LEFT JOIN [dbo].[Compensation] b ON a.ID = b.ID 
  LEFT JOIN Reasons r ON a.Reason_for_absence = r.Number -- find the healthiest employees for the bonus 
SELECT 
  * 
FROM 
  [dbo].[Absenteeism_At_Work] 
WHERE 
  [Social_drinker] = 0 
  AND [Social_smoker] = 0 
  AND [Body_mass_index] < 25 
  AND [Absenteeism_time_in_hours] < (
    SELECT 
      AVG([Absenteeism_time_in_hours]) 
    FROM 
      [dbo].[Absenteeism_At_Work]
  ) 
  
  -- compensation rate increase for non-smokers
  
SELECT 
  COUNT(*) AS nonsmokers 
FROM 
  [dbo].[Absenteeism_At_Work] 
WHERE 
  [Social_smoker] = 0 
  
  -- optimize this query
  
SELECT 
  a.ID, 
  r.Reason, 
  Month_of_absence, 
  Body_mass_index, 
  CASE WHEN Body_mass_index < 18.5 THEN 'Underweight' WHEN Body_mass_index BETWEEN 18.5 
  AND 25 THEN 'Healthy Weight' WHEN Body_mass_index BETWEEN 25 
  AND 30 THEN 'Overwieght' WHEN Body_mass_index > 30 THEN 'Obese' ELSE 'Unkown' END AS BMI_Category, 
  CASE WHEN [Month_of_absence] IN (12, 1, 2) THEN 'Winter' WHEN [Month_of_absence] IN (3, 4, 5) THEN 'Spring' WHEN [Month_of_absence] IN (6, 7, 8) THEN 'Summer' WHEN [Month_of_absence] IN (9, 10, 11) THEN 'Fall' ELSE 'Unkown' END AS Season_Names, 
  [Month_of_absence], 
  [Day_of_the_week], 
  [Transportation_expense], 
  [Education], 
  [Son], 
  [Social_drinker], 
  [Social_smoker], 
  [Pet], 
  [Disciplinary_failure], 
  [Age], 
  [Work_load_Average_day], 
  [Absenteeism_time_in_hours] 
FROM 
  [dbo].[Absenteeism_At_Work] a 
  LEFT JOIN [dbo].[Compensation] b ON a.ID = b.ID 
  LEFT JOIN Reasons r ON a.Reason_for_absence = r.Number
