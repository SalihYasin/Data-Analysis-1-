# Vita Nova Absenteeism At Work Data
## An SQL Data Visualization Project
### by salihyasincetin@hotmail.com

In this project, I will visualize the data set given to me with the help of appropriate SQL and PowerBI.

These data sets contain information about the sales of the Vita Nova company. We want to restructure and visualize data in a more organized and make some calculations and create a Dashboard.

1. Reviewing Incoming Job Request
2. Determining What Needs To Be Done Regarding The Job
3. Determining The Columns We Need From Two Different Tables
4. Identifying The Healthiest Employees Using Filters
5. Finding The Number Of Non-Smokers And Calculating Compensation Increases
6. Adding New Dimensions To The Table
7. Visualization Of Data
8. Making a Presentation To The Employer

In the Job Demand pdf file, I have tabulated what needs to be done about the job offer we receive on the next page of the pdf. When I told Mr. Bryan Campbell that it was suitable for me, he sent me 3 csv files. These were different data belonging to the company.

We have 3 tables and the most comprehensive of these tables is [dbo].[Absenteeism_At_Work].

Let's take a look at some parts of this table.

| ID  | Reason_for_absence | Month_of_absence | Day_of_the_week | Seasons | Transportation_expense | Distance_from_Residence_to_Work | Service_time | Age | Work_load_Average_day | Hit_target | Disciplinary_failure | Education | Son | Social_drinker | Social_smoker | Pet | Weight | Height | Body_mass_index | Absenteeism_time_in_hours |
|-----|--------------------|------------------|-----------------|---------|------------------------|---------------------------------|--------------|-----|-----------------------|------------|----------------------|-----------|-----|----------------|---------------|-----|--------|--------|-----------------|---------------------------|
| 1   | 26                 | 7                | 3               | 1       | 289                    | 36                              | 13           | 33  | 239554                | 97         | 0                    | 1         | 2   | 1              | 0             | 1   | 90     | 172    | 30              | 4                         |
| 2   | 0                  | 7                | 3               | 1       | 118                    | 13                              | 18           | 50  | 239554                | 97         | 1                    | 1         | 1   | 1              | 0             | 0   | 98     | 178    | 31              | 0                         |
| 3   | 23                 | 7                | 4               | 1       | 179                    | 51                              | 18           | 38  | 239554                | 97         | 0                    | 1         | 0   | 1              | 0             | 0   | 89     | 170    | 31              | 2                         |
| 4   | 7                  | 7                | 5               | 1       | 279                    | 5                               | 14           | 39  | 239554                | 97         | 0                    | 1         | 2   | 1              | 1             | 0   | 68     | 168    | 24              | 4                         |
| 5   | 23                 | 7                | 5               | 1       | 289                    | 36                              | 13           | 33  | 239554                | 97         | 0                    | 1         | 2   | 1              | 0             | 1   | 90     | 172    | 30              | 2                         |

- Let's add some filters to our query to find the healthiest people, which is the first data requested from us. The filters I will add are as follows:
  -   First, I choose users who do not drink alcohol or smoke.
    ````sql
     WHERE [Social_drinker] = 0 
     AND [Social_smoker] = 0
   ```` 
  - Then, I add people whose body mass index is less than 25 and whose work absenteeism is less than the average absenteeism to our filter.
   ````sql
    AND [Body_mass_index] < 25
    AND [Absenteeism_time_in_hours] < (SELECT AVG([Absenteeism_time_in_hours]) FROM [dbo].[Absenteeism_At_Work])
   ````

   Let's see what our results table looks like.

| ID  | Reason_for_absence | Month_of_absence | Day_of_the_week | Seasons | Transportation_expense | Distance_from_Residence_to_Work | Service_time | Age | Work_load_Average_day | Hit_target | Disciplinary_failure | Education | Son | Social_drinker | Social_smoker | Pet | Weight | Height | Body_mass_index | Absenteeism_time_in_hours |
|-----|--------------------|------------------|-----------------|---------|------------------------|---------------------------------|--------------|-----|-----------------------|------------|----------------------|-----------|-----|----------------|---------------|-----|--------|--------|-----------------|---------------------------|
| 41  | 23                 | 9                | 3               | 1       | 184                    | 42                              | 7            | 27  | 241476                | 92         | 0                    | 1         | 0   | 0              | 0             | 0   | 58     | 167    | 21              | 2                         |
| 52  | 0                  | 9                | 2               | 4       | 225                    | 26                              | 9            | 28  | 241476                | 92         | 1                    | 1         | 1   | 0              | 0             | 2   | 69     | 169    | 24              | 0                         |
| 53  | 23                 | 9                | 3               | 4       | 225                    | 26                              | 9            | 28  | 241476                | 92         | 0                    | 1         | 1   | 0              | 0             | 2   | 69     | 169    | 24              | 2                         |
| 57  | 18                 | 9                | 4               | 4       | 225                    | 26                              | 9            | 28  | 241476                | 92         | 0                    | 1         | 1   | 0              | 0             | 2   | 69     | 169    | 24              | 3                         |
| 66  | 23                 | 10               | 5               | 4       | 179                    | 26                              | 9            | 30  | 253465                | 93         | 0                    | 3         | 0   | 0              | 0             | 0   | 56     | 171    | 19              | 1                         |

We can move on to our next task...

- To calculate the compensation rate increase, let's look at how many employees are non-smokers. We will name the column where this number will be found "nonsmokers"
   ````sql
    SELECT COUNT(*) AS nonsmokers
    FROM [dbo].[Absenteeism_At_Work]
    WHERE [Social_smoker] = 0
   ````
   The result is : 686

  We will need a calculator to calculate the compensation rate increase.

  - First, we need to calculate how many hours 686 works in total in a year;
  
  8 for hours worked per day

  5 for days worked in a week

  52 for weeks worked in 1 year

  686 for number of employees

  ### 8 x 5 x 52 x 686 = 1,426,880 ###

  Non-smoking employees work a total of 1,426,880 hours in a year. This is great!

  - Since we know that the total compensation decrease is 983221, this time we can calculate the amount of compensation decrease per hour;
  983,221 for annual compensation reduction amount
  1,426,880 for annual working hours of all workers

  ### 983,221 / 1,426,880 = 0.6890

  - Finally, let's find out how much compensation reduction a non-smoking employee will receive annually;

  2080 for a person's annual working hours
  0.689 for hourly compensation reduction fee

  ### 2080 x 0.689 = 1,414.4

- We carried out all the procedures requested from us. All that remains is to optimize this table :

````sql
   SELECT
a.ID,
r.Reason,
Month_of_absence,
Body_mass_index,
CASE WHEN Body_mass_index <18.5 THEN 'Underweight'
     WHEN Body_mass_index BETWEEN 18.5 AND 25 THEN 'Healthy Weight'
     WHEN Body_mass_index BETWEEN 25 AND 30 THEN 'Overwieght'
     WHEN Body_mass_index > 30 THEN 'Obese'
	 ELSE 'Unkown'
	 END AS BMI_Category,
CASE WHEN [Month_of_absence] IN (12,1,2) THEN 'Winter'
     WHEN [Month_of_absence] IN (3,4,5) THEN 'Spring'
     WHEN [Month_of_absence] IN (6,7,8) THEN 'Summer'
     WHEN [Month_of_absence] IN (9,10,11) THEN 'Fall'
ELSE 'Unkown' 
END AS Season_Names,
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
FROM [dbo].[Absenteeism_At_Work] a 
LEFT JOIN [dbo].[Compensation] b
ON a.ID = b.ID
LEFT JOIN Reasons r 
ON a.Reason_for_absence = r.Number
````
  
