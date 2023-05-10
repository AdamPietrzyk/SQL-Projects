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
