## Project overview
The presented database is a simple system that tracks basic information related to blood donation and transfusion operations.
The database was created using MySQL software, with the assistance of MySQL Workbench.

I completed the entire project on my own, starting from the stage of designing the database structure, loading data, and writing queries for analysis purposes.

## Database structure

### Tables
The database consists of 10 tables as below:
- **BloodType**: contains information about blood types.
- **RhFactor**: contains information about Rh blood factors.
- **Inventory**: contains information about the current stock level for each combination of blood type and Rh factor.
- **Donator_Level**: contains information about blood donor levels, which are awarded after reaching a certain threshold of donated blood.
- **Patients**: contains information about patients who are blood donors.
- **Staff**: contains information about medical staff.
- **Institutions**: contains information about medical institutions.
- **Donations**: contains information about blood donations made.
- **Recipients**: contains information about blood recipients.
- **Transfusions**: contains information about performed blood transfusions.

### Triggers
In this project, I also implemented triggers to optimize the operations performed.
For example, adding each new record to the "Donations" table automatically triggers the summing of values in the "Inventory" table, ensuring that the total blood inventory is always up to date. Similarly, adding each new record to the "Transfusions" table results in subtracting the corresponding amount of blood from the Inventory table.
Another example of trigger usage is automating the calculation of the total amount of blood donated by each patient in the "Patients" table. Additionally, when a patient exceeds a certain threshold of blood donation, their status is automatically updated.

### Analysis of data
In order to analyze the data, I have prepared 16 questions of varying difficulty levels. To answer them, I have created 16 SQL queries. All the questions along with their queries can be found in the file "3. Queries and analysis".

For example, a question number 7 is "What is the percentage of each combination of blood type and Rh factor in the overall blood volume?"
And the query that is going to give an answer is:
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

The result is:
<img width="277" alt="Zrzut ekranu 2023-05-10 o 19 22 06" src="https://github.com/AdamPietrzyk/SQL-Projects/assets/127242593/ae07f107-efb9-40ff-ac97-2c5585280ebb">


