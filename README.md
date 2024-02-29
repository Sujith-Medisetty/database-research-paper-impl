# MYSQL Technical Paper Implementation 
## The paper associated with this project can be found [here](https://www.sciencedirect.com/science/article/pii/S1877050916318208?ref=pdf_download&fr=RR-2&rr=85cd52c01f9f458f).


# Introduction / Abstract

This repository introduces a database system designed to protect sensitive information effectively. By segmenting data into smaller tables based on sensitivity levels (segregation), the system ensures security while maintaining data integrity. Encryption adds an extra layer of protection for sensitive data. The system's dynamic workflow establishes logical relationships between tables, ensuring real-time data integrity.

## Segregating Information based on its Sensitivity Level

To mitigate unauthorized access, sensitive data is divided into separate tables. The entity relationship diagram illustrates this segregation, emphasizing the separation of highly sensitive attributes such as `Patient_Health_Insu_No` and `Patient_Social_Insu_No` into distinct tables—`Patient_Health_INS_Table` and `Patient_Social_INS_Table`.

## Dynamic Referential Integrity

Instead of directly establishing referential integrity within tables, the system uses predefined PL/SQL procedures to create relationships at runtime. These procedures dynamically establish logical connections between tables based on parameters such as table names and column names, enhancing security and preventing reverse engineering attacks.

## Reducing Unauthorized Access via Encryption

Combining data segregation with encryption techniques significantly reduces the risk of unauthorized access. Triggers encrypt sensitive information during insertion into their respective tables, ensuring minimal exposure even if unauthorized parties gain partial access.

## Audit Logging

Triggers are implemented to log operations on sensitive tables like `Patient_Social_INS_Table` and `Patient_Health_INS_Table` for traceability and accountability. The `Operation_Log` table captures operation types, affected tables, and corresponding row IDs for comprehensive auditing.

## Performance Evaluation

The performance evaluation demonstrates varying execution times for inserting and retrieving records under different configurations. Inserting 10,000 records ranges from 32 to 37 seconds, with the highest time observed when encryption and log triggers are both active. Retrieving 10,000 records without decryption shows minimal time impact, while decryption introduces a slight delay, with the highest recorded time being 15 seconds. These findings highlight the trade-offs between security measures and performance in the database system.


| Operation                       | Insert              | Pharmacy | Patient_Generic_Details_Table | Patient_Social_INS_Table | Patient_Health_INS_Table |
|---------------------------------|---------------------|----------|--------------------------------|---------------------------|--------------------------|
| No encryption, no log triggers  | Insert 10k records | 34 sec   | 35 sec                         | 35 sec                    | 32 sec                   |
| No encryption, with log triggers| Insert 10k records | -        | -                              | 32 sec                    | 35 sec                   |
| With encryption, no log triggers| Insert 10k records | -        | -                              | 32 sec                    | 32 sec                   |
| With encryption and log triggers| Insert 10k records | -        | -                              | 36 sec                    | 37 sec                   |
| Without decryption              | Retrieve 10k records| 0 sec  | 0 sec                          | 0 sec                     | 0 sec                    |
| With decryption                 | Retrieve 10k records| 0 sec  | 0 sec                          | 15 sec                    | 0 sec                    |


**Note:** Encryption and logging are not implemented for the following tables: Pharmacy, Patient_Generic_Details_Table (shown as black in the evaluation).

# Below are the validation screenshots:
## Insertion Time

- Patient_Generic_Details_Table_insertion_time.png
- Patient_Health_INS_Table_insertion_time.png
- Pharmacy_insertion_time.png
- Patient_Social_INS_Table_insertion_time.png

## Selection Time

- Patient_Social_INS_Table_selection_time.png
- Patient_Health_INS_Table_selection_time.png

### ER-Diagram can be found in ER-Diagram.png

# Dummy Data SQL Scripts

This repository includes SQL scripts containing dummy data generated with the help of [filldb.info](https://filldb.info/dummy). Below are the SQL script files for each table:

- Pharmacy Dummy Data
Pharmacy_dummy_data.sql- SQL script containing dummy data for the Pharmacy table.

- Patient Generic Details Table Dummy Data
Patient_Generic_Details_Table_dummy_data.sql - SQL script containing dummy data for the Patient_Generic_Details_Table.

- Patient Social INS Table Dummy Data
Patient_Social_INS_Table_dummy_data.sql - SQL script containing dummy data for the Patient_Social_INS_Table.

- Patient Health INS Table Dummy Data
Patient_Health_INS_Table_dummy_data.sql - SQL script containing dummy data for the Patient_Health_INS_Table.

