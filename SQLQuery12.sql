--Every month the Texas Department of Criminal Justice(TDCJ) releases a "High Value Dataset" which contains "On hand inmate population with relevant demographic, offense, and parole information."
--We are going to explore this data for June 2021 to look for insights on the current prison population in Texas.

SELECT * FROM TXJune2021

--We start by taking a look at the entire dataset. One thing we see is that there 118,139 rows(inmates) of data. One thing I would like to change to help with queries is updating column
--names to remove spaces. I'm not going to update all columns, just ones I will most likely be using.

EXEC sp_rename 'TXJune2021.Projected Release', 'ProjectedRelease', 'COLUMN'
EXEC sp_rename 'TXJune2021.Current Facility', 'CurrentFacility', 'COLUMN'
EXEC sp_rename 'TXJune2021.Maximum Sentence Date', 'MaximumSentenceDate', 'COLUMN'
EXEC sp_rename 'TXJune2021.Parole Eligibility Date', 'ParoleEligibilityDate', 'COLUMN'
EXEC sp_rename 'TXJune2021.Case Number', 'CaseNumber', 'COLUMN'
EXEC sp_rename 'TXJune2021.Offense Code', 'OffenseCode', 'COLUMN'
EXEC sp_rename 'TXJune2021.TDCJ Offense', 'TDCJOffense', 'COLUMN'
EXEC sp_rename 'TXJune2021.Sentence (Years)', 'SentenceYears', 'COLUMN'

--Now that we have everything cleaned up a little let's see how many inmates are at each facility(CurrentFacility).

SELECT CurrentFacility, COUNT(*) as Population FROM TXJune2021
GROUP BY CurrentFacility
ORDER BY Population DESC; 

--SELECT COUNT DISTINCT(OffenseCode) FROM TXJune2021

--Next we will look at the breakdown of each gender as well as the population percentage of each.

SELECT Gender, COUNT(*) as Prisoners, 
	FLOOR(count(*) * 100.0/ sum(count(*)) over ()) as Total_Population_Percentage
FROM TXJune2021
GROUP BY Gender; 

--SELECT COUNT(Gender) as Female_Inmates 
FROM TXJune2021
WHERE Gender = 'F';

SELECT COUNT(Gender) FROM TXJune2021
WHERE Gender = 'M'

SELECT COUNT(*) FROM TXJune2021
WHERE [projected release] < "2030-01-01"
