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



## Analysis of data
In order to analyze the data, I have prepared 16 questions of varying difficulty levels. To answer them, I have created 16 SQL queries. All the questions along with their queries can be found in the file "3. Queries and analysis".

For example, a question number 7 is "What is the percentage of each combination of blood type and Rh factor in the overall blood volume?"
And the query that is going to give an answer is:


<img width="533" alt="Zrzut ekranu 2023-05-10 o 19 26 20" src="https://github.com/AdamPietrzyk/SQL-Projects/assets/127242593/e11455a5-5967-42ab-9cfe-0fd9d397d2cb">


The result is:


<img width="277" alt="Zrzut ekranu 2023-05-10 o 19 22 06" src="https://github.com/AdamPietrzyk/SQL-Projects/assets/127242593/ae07f107-efb9-40ff-ac97-2c5585280ebb">



## Data visualisation
For better and more convenient visualization of the results, I used PowerBI software. After loading the data, I created a simple dashboard, which is presented below. Due to limitations in sharing the dashboard, I am attaching two files. The first file is a screenshot of a dashboard, and it does not have any active filters applied.



<img width="1393" alt="Zrzut ekranu 2023-05-10 o 19 34 55" src="https://github.com/AdamPietrzyk/SQL-Projects/assets/127242593/1b16bc8e-4c3e-4b47-90a8-993c16487048">



The second screenshot shows the dashboard with active filters. The highlighted elements correspond to the following applied filters:
- gender: M (male)
- BloodType: 0+



<img width="1393" alt="Zrzut ekranu 2023-05-10 o 19 35 08" src="https://github.com/AdamPietrzyk/SQL-Projects/assets/127242593/a0b203b7-2d17-46c1-a5e6-610438b9f33b">




The dashboard clearly shows that when considering the above filters, 37 males have donated blood (blood type 0+), which accounts for 29% of the total. Among these males, 24 individuals donated blood at Institution_B, while 13 individuals donated blood at Institution_A.
