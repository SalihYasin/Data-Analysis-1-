DROP TABLE IF EXISTS [dbo].[Absenteeism_At_Work] ;
CREATE TABLE [dbo].[Absenteeism_At_Work] (
       [ID] [smallint],
	     [Reason_for_absence] [tinyint],
	     [Month_of_absence] [tinyint],
	     [Day_of_the_week] [tinyint],
	     [Seasons] [tinyint],
	     [Transportation_expense] [smallint],
	     [Distance_from_Residence_to_Work] [tinyint],
	     [Service_time] [tinyint],
	     [Age] [tinyint],
	     [Work_load_Average_day] [int],
	     [Hit_target] [tinyint],
	     [Disciplinary_failure] [bit],
	     [Education] [tinyint],
	     [Son] [tinyint],
	     [Social_drinker] [bit],
	     [Social_smoker] [bit],
	     [Pet] [tinyint],
	     [Weight] [tinyint],
	     [Height] [tinyint],
	     [Body_mass_index] [tinyint],
	     [Absenteeism_time_in_hours] [tinyint]
    ) ,

DROP TABLE IF EXISTS [dbo].[Compensation] ;
CREATE TABLE [dbo].[Compensation]  (
      [ID] [smallint],
	    [comp_hr] [tinyint] 
    ) ,

DROP TABLE IF EXISTS [dbo].[Reasons] ;
CREATE TABLE [dbo].[Reasons] (
       [Number] [tinyint],
	     [Reason] [nvarchar](100)

from 'C:\Users\PLANLAMA\Desktop\Absenteeism_at_work.csv'
     'C:\Users\PLANLAMA\Desktop\compensation.csv'
     'C:\Users\PLANLAMA\Desktop\Reasons.csv'
delimiter ',' csv header;
