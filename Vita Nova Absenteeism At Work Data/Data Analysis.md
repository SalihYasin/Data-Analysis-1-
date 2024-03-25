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
As a result of this code, we will no longer see the columns we do not want to see in our table. In addition, even a person who does not understand the values of body mass index will now be able to have an idea about the person's weight status when looking at our table. and in the last change we made, a column showing the season in which the absence occurred.

- Now that we have put our table in the form we want with SQL queries, we can now transfer our table to our Microsoft Power BI application and visualize our data to make a presentation.

Before starting the visualization process, I created a wire frame in my head. Preparing such a template before starting the visualization and sharing it with the company before the end of the project makes my work easier and the company gets exactly what it wants in the final.

Here's the wireframe I prepared:

![wireframe](https://github.com/SalihYasin/Data-Analysis-1-/assets/117492474/f64268fa-a136-401a-8fd8-89e7cf366959)

- I will start making additions to our dashboard from the main KPI section at the top left, and the first item I add will be the average absence time in hours.

This is the most important indicator among all indicators. so we'll put it at the top

![maın kpı](https://github.com/SalihYasin/Data-Analysis-1-/assets/117492474/7286a0ef-87c5-4497-84fa-a5efb9892719)

- Secondly, I will add a narrative part.

It is very important that we create a narrative that will support that most important indicator in terms of text usage and detailing.
  
![Narrative](https://github.com/SalihYasin/Data-Analysis-1-/assets/117492474/687f4e42-0b38-4749-969e-4c208e1a3682)

- Now we move on to the next section and I will add secondary KPI.

This part will consist of two parts. The first part will show the total number of employees and the second part will show the total absences made.

![Secondary KPI](https://github.com/SalihYasin/Data-Analysis-1-/assets/117492474/cc209ab8-18a2-40e8-ac86-c631cf65d751)

- Let's add 4 Pie charts to the side as we planned.

The first of these pie charts will show us the education level, the second will show us the place of pet ownership, and the third and fourth charts will show us about smoking and drinking alcohol.

![pie chartsss](https://github.com/SalihYasin/Data-Analysis-1-/assets/117492474/3a906d39-8dde-45c4-bbc8-0c4e58e5407f)

- Next up are the Monthly and Weekly Breakdown sections.

These two graphs allow us to make a comparison between the month and day of absence and the average absence. I will also add another section to the left of these two graphs where we can select the seasons.

![Monthly and Weekly Breakdown](https://github.com/SalihYasin/Data-Analysis-1-/assets/117492474/1c7dbb13-22fd-4b82-ab62-0c7b58045234)

- We have come to the last part: table breakdown and scatter plot variable comparison part

While the indicator on the left of this section gives us an idea about the reason for absenteeism through numbers, the indicator on the right gives us a visual idea in the form of a distribution graph.

![Table Breakdown and ](https://github.com/SalihYasin/Data-Analysis-1-/assets/117492474/a9f84080-a699-4b3e-a2c1-d15708922dde)

Now that we have added all the graphics we specified on the wireframe and are sure that all our buttons are working, we are ready to see the final version of our table. Now that we have saved our table, I will need to go to the company for the presentation.

![absenteııısm fınals ‐ Clipchamp ile yapıldı (1)](https://github.com/SalihYasin/Data-Analysis-1-/assets/117492474/609281d8-25f4-4161-ab5d-3752d31b0e00)

