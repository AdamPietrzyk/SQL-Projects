# 1. How much blood did women and men donate? In total, regardless of blood type and Rh factor.
SELECT p.gender, SUM(d.DonationQuantity)
FROM Patients p
	JOIN Donations d
		ON p.ID_Patient = d.ID_Patient
GROUP BY p.gender;



#2. How many donors are women, and how many donors are men?
SELECT COUNT(ID_Patient), gender
FROM Patients
GROUP BY gender;



#3. How many donors have the last name "Kowalski"?
SELECT COUNT(*), last_name
FROM Patients
WHERE last_name LIKE "Kowalski"
GROUP BY last_name;


#4. How many donors have which blood type?
SELECT COUNT(*), bt.BloodType
FROM Patients p
	JOIN BloodType bt
		ON p.ID_BloodType = bt.ID_BloodType
GROUP BY bt.BloodType;



#5. How many donors have each combination of blood type and Rh factor?
SELECT bt.BloodType, rf.RhFactor, COUNT(*)
FROM Patients p
	JOIN BloodType bt
		ON p.ID_BloodType = bt.ID_BloodType
	JOIN RhFactor rf
		ON p.ID_RhFactor = rf.ID_RhFactor
GROUP BY bt.BloodType, rf.RhFactor
ORDER BY bt.BloodType;



#6. What is the percentage of individuals with each blood type and Rh factor in the total number of individuals?
SELECT
	bt.BloodType,
    	rf.RhFactor,
    	COUNT(*),
    	ROUND(count(*) * 100.0 / sum(count(*)) Over(), 2) AS Percentage
FROM Patients p
	JOIN BloodType bt
		ON p.ID_BloodType = bt.ID_BloodType
	JOIN RhFactor rf
		ON p.ID_RhFactor = rf.ID_RhFactor
GROUP BY bt.BloodType, rf.RhFactor
ORDER BY BloodType;



#7. What is the percentage of each combination of blood type and Rh factor in the overall blood volume?
SELECT
	bt.BloodType,
   	rf.RhFactor,
   	SUM(d.DonationQuantity) AS 'Sum of donated quantity',
    	ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),2) AS Percentage
FROM Patients p
	JOIN Donations d
		ON p.ID_Patient = d.ID_Patient
	JOIN BloodType bt
		ON p.ID_BloodType = bt.ID_BloodType
	JOIN RhFactor rf
		ON p.ID_RhFactor = rf.ID_RhFactor
GROUP BY bt.BloodType, rf.RhFactor
ORDER BY BloodType;



#8. How many individuals are from each city?
SELECT COUNT(*), address_city
FROM Patients
GROUP BY address_city
ORDER BY COUNT(*) DESC;



#9. How many donations took place at each institution, and what is the blood type, Rh factor, and gender associated with each donation?
SELECT
	COUNT(*),
    bt.BloodType,
    rf.RhFactor,
    i.ID_Institution,
    p.gender
FROM Patients p
	JOIN Donations d
		ON p.ID_Patient = d.ID_Patient
	JOIN RhFactor rf
		ON p.ID_RhFactor = rf.ID_RhFactor
	JOIN BloodType bt
		ON p.ID_BloodType = bt.ID_BloodType
	JOIN Institutions i
		ON d.ID_Institution = i.ID_Institution
GROUP BY bt.BloodType, rf.RhFactor, i.ID_Institution, p.gender
ORDER BY i.ID_Institution, bt.BloodType, rf.RhFactor;


#10. How much blood (blood type and Rh factor) was donated in each month?
SELECT
	MONTH(d.Donation_Date) as Months,
    bt.BloodType,
    rf.RhFactor,
    SUM(d.DonationQuantity),
	GROUPING(bt.BloodType),
	GROUPING(rf.RhFactor)
FROM Patients p
	JOIN Donations d
		ON p.ID_Patient = d.ID_Patient
	JOIN RhFactor rf
		ON p.ID_RhFactor = rf.ID_RhFactor
	JOIN BloodType bt
		ON p.ID_BloodType = bt.ID_BloodType
GROUP BY Months, bt.BloodType, rf.RhFactor WITH ROLLUP;

# Same as above, but using "if grouping"

SELECT
	MONTH(d.Donation_Date) as Months,
		IF(GROUPING(bt.BloodType),
        'All Blood Types for this Month', bt.BloodType) BloodType,
		IF(GROUPING(rf.RhFactor),
        'All Rh Factors for this BloodType', rf.RhFactor) RhFactor,
        #IF(GROUPING(months), 'all months', months) months,
	SUM(d.DonationQuantity)
FROM Patients p
	JOIN Donations d
		ON p.ID_Patient = d.ID_Patient
	JOIN RhFactor rf
		ON p.ID_RhFactor = rf.ID_RhFactor
	JOIN BloodType bt
		ON p.ID_BloodType = bt.ID_BloodType
GROUP BY Months, bt.BloodType, rf.RhFactor WITH ROLLUP;



#11. How much blood did the patient with ID 111 donate in total?
SELECT CONCAT(p.first_name, ' ', p.last_name), SUM(d.DonationQuantity)
FROM Patients p
	JOIN Donations d
		ON p.ID_Patient = d.ID_Patient
WHERE d.ID_Patient = 111;



#12. Checking if there is a patient who has not donated any blood at all?
SELECT * FROM Patients
WHERE DonatedAmount IS NULL;
#te 2 osoby nie oddały krwi w ogóle



#13. Prepare a query using CASE WHEN statement.
SELECT
	ID_Patient, first_name, last_name,
CASE
	WHEN gender = 'M' THEN 'Male'
    WHEN gender = 'F' THEN 'Female'
END
FROM Patients;



#14. Write a query with a subquery.
SELECT
	ID_Patient,
    first_name,
    last_name,
    DonatedAmount
FROM Patients
WHERE DonatedAmount > (SELECT AVG(DonatedAmount) FROM Patients);



# 15. Use derived table
# An example of a query using a derived table can be a query selecting the sum of all donations from Inventory for each blood type.
SELECT bt.BloodType, rf.RhFactor, sum(inv.Quantity) AS TotalQuantity
FROM BloodType bt
CROSS JOIN RhFactor rf
LEFT JOIN (
    SELECT ID_BloodType, ID_RhFactor, Quantity
    FROM Inventory
) AS inv ON bt.ID_BloodType = inv.ID_BloodType AND rf.ID_RhFactor = inv.ID_RhFactor
GROUP BY bt.BloodType, rf.RhFactor
ORDER BY bt.BloodType, rf.RhFactor;



# 16. Use CTE
# Example query using Common Table Expression (CTE) that finds the latest blood donation date for each blood type and RhFactor in the Donations table.
WITH LatestDonations AS (
	SELECT p.ID_BloodType, p.ID_RhFactor, MAX(d.Donation_Date) AS LatestDate
    FROM Donations d
		JOIN Patients p
			ON d.ID_Patient = p.ID_Patient
	GROUP BY p.ID_BloodType, p.ID_RhFactor
    )
    SELECT bt.BloodType, rf.RhFactor, ld.LatestDate
    FROM Patients p
		JOIN BloodType bt
			ON p.ID_BloodType = bt.ID_BloodType
        JOIN RhFactor rf
			ON p.ID_RhFactor = rf.ID_RhFactor
        JOIN LatestDonations ld
			ON ld.ID_BloodType = bt.ID_BloodType AND ld.ID_RhFactor = rf.ID_RhFactor
	GROUP BY bt.BloodType, rf.RhFactor, ld.LatestDate
    ORDER BY bt.BloodType, rf.RhFactor;
