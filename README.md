# Database Management SQL Project

This project demonstrates the design and implementation of a relational database using **MySQL/MariaDB, XAMPP, phpMyAdmin, and SQL**. It was developed as part of a database management assignment and focuses on relational schema design, SQL querying, table relationships, and database integrity constraints.

## Project Overview

The database models a healthcare system containing hospitals, physicians, patients, specialties, insurance coverage policies, consultations, and diagnoses.

The project demonstrates:

- Database and table creation using SQL
- Primary key and foreign key constraints
- Relational database design
- Data loading and table validation
- Filtering and sorting queries
- `INNER JOIN` and `LEFT JOIN`
- Aggregate functions such as `COUNT()` and `AVG()`
- `GROUP BY` and `HAVING`
- Common Table Expressions (CTEs)
- Referential integrity
- Constraint violation testing

## Technologies Used

- MySQL / MariaDB
- XAMPP
- phpMyAdmin
- SQL

## Database

Database name:

```sql
apc_db
```

## Database Tables

| Table | Purpose |
| --- | --- |
| `Hospital` | Stores hospital information |
| `Hospital_Location` | Stores hospital locations |
| `Physician` | Stores physician information and hospital assignments |
| `Speciality` | Stores medical specialties |
| `Physician_Speciality` | Connects physicians with their specialties |
| `CoveragePolicy` | Stores insurance/coverage policy information |
| `Patient` | Stores patient information |
| `Consultation` | Stores consultation and follow-up information |
| `Diagnosis` | Stores diagnoses associated with consultations |

## Database Relationships

The schema uses primary and foreign keys to maintain relationships between tables.

Examples:

- A physician can be associated with a hospital.
- A physician can have one or more specialties.
- A patient can be assigned to a physician.
- A patient can be associated with a coverage policy.
- A consultation connects a patient with a physician.
- A diagnosis is associated with a consultation.

## SQL Concepts Demonstrated

### Filtering

```sql
SELECT p.PName AS PatientName, p.Address AS Address
FROM patient p
WHERE p.DateOfBirth > '1990-01-01';
```

### Pattern Matching

```sql
SELECT FName AS FirstName, LName AS LastName
FROM physician
WHERE LName LIKE 'K%';
```

### Sorting

```sql
SELECT SName AS SpecialityName
FROM speciality
ORDER BY SName;
```

### Joins

```sql
SELECT CONCAT(ph.FName, ' ', ph.LName) AS PhysicianName,
       h.HName AS HospitalName
FROM physician_speciality ps
JOIN speciality s ON s.SName = ps.SName
JOIN physician ph ON ph.PId = ps.PId
JOIN hospital h ON h.HId = ph.HId
WHERE s.SName = 'General Surgery'
ORDER BY PhysicianName;
```

### Aggregation

```sql
SELECT h.HName AS HospitalName,
       COUNT(ph.PId) AS PhysicianCount
FROM hospital h
LEFT JOIN physician ph ON ph.HId = h.HId
GROUP BY h.HId, h.HName
ORDER BY h.HName;
```

### GROUP BY and HAVING

```sql
SELECT p.PName AS PatientName
FROM patient p
JOIN consultation c ON c.PSSN = p.PSSN
GROUP BY p.PSSN, p.PName
HAVING COUNT(*) = 2
ORDER BY p.PName;
```

### Common Table Expression

```sql
WITH hs AS (
    SELECT h.HId,
           h.HName,
           COUNT(DISTINCT ps.SName) AS DistinctSpecialities
    FROM hospital h
    JOIN physician ph ON ph.HId = h.HId
    JOIN physician_speciality ps ON ps.PId = ph.PId
    GROUP BY h.HId, h.HName
),
mx AS (
    SELECT MAX(DistinctSpecialities) AS m
    FROM hs
)
SELECT hs.HName AS HospitalName,
       hs.DistinctSpecialities
FROM hs
JOIN mx ON hs.DistinctSpecialities = mx.m;
```

## Integrity Constraints

The project also tests database integrity by attempting operations that violate constraints, including:

- Duplicate primary keys
- `NULL` values in required primary-key fields
- Foreign-key references to records that do not exist
- Updates and deletes that violate referential integrity

These examples demonstrate how a relational database protects data consistency.

## Running the Project Locally

1. Install and open **XAMPP**.
2. Start **Apache** and **MySQL**.
3. Open phpMyAdmin at:

   `http://localhost/phpmyadmin`

4. Create or import the `apc_db` database.
5. Import the SQL file from this repository.
6. Select `apc_db` in phpMyAdmin.
7. Run the SQL queries included in the project.

To verify the imported tables:

```sql
SHOW TABLES;
```

To inspect a table:

```sql
SELECT * FROM table_name;
```

## Learning Outcomes

Through this project, I practiced:

- Designing relational database schemas
- Defining primary and foreign keys
- Writing multi-table SQL queries
- Working with joins and aggregate functions
- Applying grouping and filtering logic
- Using CTEs for more complex SQL queries
- Understanding entity and referential integrity
- Managing MySQL databases with XAMPP and phpMyAdmin

## Repository Structure

A clean repository structure can look like this:

```text
database-management-sql-project/
├── database/
│   └── apc_db.sql
├── queries/
│   └── queries.sql
├── screenshots/
└── README.md
```

## Author

**Avanish Gajula**

GitHub: [avanishgajula](https://github.com/avanishgajula)
