CREATE DATABASE hospital;

USE hospital;


-- Create Patient_Health_INS_Table
CREATE TABLE Patient_Health_INS_Table (
    Patient_Id INT PRIMARY KEY,
    Patient_Health_Insu_No VARBINARY(255)
);

-- Create Patient_Social_INS_Table
CREATE TABLE Patient_Social_INS_Table (
    Patient_Id INT PRIMARY KEY,
    Patient_Social_Insu_No VARBINARY(255)
);

-- Create Pharmacy
CREATE TABLE Pharmacy (
    Pharmacy_ID INT PRIMARY KEY,
    Pharmacy_Name VARCHAR(255),
    Pharmacy_Address VARCHAR(255),
    Pharmacy_Contact_No VARCHAR(15)
);

-- Create Patient_Generic_Details_Table
CREATE TABLE Patient_Generic_Details_Table (
    Patient_Id INT PRIMARY KEY,
    Pharmacy_Id INT,
    Patient_Name VARCHAR(255),
    Patient_Gender VARCHAR(10),
    Patient_Birthdate DATE,
    Patient_Address VARCHAR(255),
    Patient_Contact_No VARCHAR(15),
    FOREIGN KEY (Pharmacy_Id) REFERENCES Pharmacy(Pharmacy_ID)
);



-- Procedure to create foreign key constraint between Patient_Generic_Details_Table and Patient_Health_INS_Table
DELIMITER //

CREATE PROCEDURE Create_FK_Health_INS (
    IN health_table_name VARCHAR(255),
    IN generic_table_name VARCHAR(255),
    IN health_column_name VARCHAR(255),
    IN generic_column_name VARCHAR(255)
)
BEGIN
    SET @sql = CONCAT('ALTER TABLE ', health_table_name, ' ADD FOREIGN KEY (', health_column_name, ') REFERENCES ', generic_table_name, '(', generic_column_name, ')');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;

-- Procedure to create foreign key constraint between Patient_Generic_Details_Table and Patient_Social_INS_Table
DELIMITER //

CREATE PROCEDURE Create_FK_Social_INS (
    IN social_table_name VARCHAR(255),
    IN generic_table_name VARCHAR(255),
    IN social_column_name VARCHAR(255),
    IN generic_column_name VARCHAR(255)
)
BEGIN
    SET @sql = CONCAT('ALTER TABLE ', social_table_name, ' ADD FOREIGN KEY (', social_column_name, ') REFERENCES ', generic_table_name, '(', generic_column_name, ')');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;


CALL Create_FK_Health_INS('Patient_Health_INS_Table','Patient_Generic_Details_Table', 'Patient_Id', 'Patient_Id');
CALL Create_FK_Social_INS('Patient_Social_INS_Table', 'Patient_Generic_Details_Table', 'Patient_Id', 'Patient_Id');


-- Trigger to encrypt data before insertion into Patient_Social_INS_Table
DELIMITER //

CREATE TRIGGER Encrypt_Social_Insu_No BEFORE INSERT ON Patient_Social_INS_Table
FOR EACH ROW
BEGIN
    SET NEW.Patient_Social_Insu_No = AES_ENCRYPT(NEW.Patient_Social_Insu_No, 'encryption_key');
END;//

DELIMITER ;


-- Trigger to encrypt data before insertion into Patient_Health_INS_Table
DELIMITER //
CREATE TRIGGER Encrypt_Health_Insu_No BEFORE INSERT ON Patient_Health_INS_Table
FOR EACH ROW
BEGIN
    SET NEW.Patient_Health_Insu_No = AES_ENCRYPT(NEW.Patient_Health_Insu_No, 'encryption_key');
END;//

DELIMITER ;


-- creating triggers to store logs if some operation happens on the data

-- Create Log Table
CREATE TABLE Operation_Log (
    Log_ID INT AUTO_INCREMENT PRIMARY KEY,
    Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Operation VARCHAR(50),
    Table_Name VARCHAR(255),
    Row_ID INT
);

-- Trigger to log insertions on Patient_Social_INS_Table
DELIMITER //
CREATE TRIGGER Log_Insert_Social_Ins AFTER INSERT ON Patient_Social_INS_Table
FOR EACH ROW
BEGIN
    INSERT INTO Operation_Log (Operation, Table_Name, Row_ID)
    VALUES ('INSERT', 'Patient_Social_INS_Table', NEW.Patient_Id);
END //
DELIMITER ;

-- Trigger to log deletions on Patient_Social_INS_Table
DELIMITER //
CREATE TRIGGER Log_Delete_Social_Ins AFTER DELETE ON Patient_Social_INS_Table
FOR EACH ROW
BEGIN
    INSERT INTO Operation_Log (Operation, Table_Name, Row_ID)
    VALUES ('DELETE', 'Patient_Social_INS_Table', OLD.Patient_Id);
END //
DELIMITER ;

-- Trigger to log updates on Patient_Social_INS_Table
DELIMITER //
CREATE TRIGGER Log_Update_Social_Ins AFTER UPDATE ON Patient_Social_INS_Table
FOR EACH ROW
BEGIN
    INSERT INTO Operation_Log (Operation, Table_Name, Row_ID)
    VALUES ('UPDATE', 'Patient_Social_INS_Table', NEW.Patient_Id);
END //
DELIMITER ;

-- Trigger to log insertions on Patient_Health_INS_Table
DELIMITER //
CREATE TRIGGER Log_Insert_Health_Ins AFTER INSERT ON Patient_Health_INS_Table
FOR EACH ROW
BEGIN
    INSERT INTO Operation_Log (Operation, Table_Name, Row_ID)
    VALUES ('INSERT', 'Patient_Health_INS_Table', NEW.Patient_Id);
END //
DELIMITER ;

-- Trigger to log deletions on Patient_Health_INS_Table
DELIMITER //
CREATE TRIGGER Log_Delete_Health_Ins AFTER DELETE ON Patient_Health_INS_Table
FOR EACH ROW
BEGIN
    INSERT INTO Operation_Log (Operation, Table_Name, Row_ID)
    VALUES ('DELETE', 'Patient_Health_INS_Table', OLD.Patient_Id);
END //
DELIMITER ;

-- Trigger to log updates on Patient_Health_INS_Table
DELIMITER //
CREATE TRIGGER Log_Update_Health_Ins AFTER UPDATE ON Patient_Health_INS_Table
FOR EACH ROW
BEGIN
    INSERT INTO Operation_Log (Operation, Table_Name, Row_ID)
    VALUES ('UPDATE', 'Patient_Health_INS_Table', NEW.Patient_Id);
END //
DELIMITER ;





-- Select query for Patient_Social_INS_Table with automatic decryption
SELECT 
    Patient_Id,
    AES_DECRYPT(Patient_Social_Insu_No, 'encryption_key') AS Decrypted_Social_Insu_No
FROM 
    Patient_Social_INS_Table;

-- Select query for Patient_Health_INS_Table with automatic decryption
SELECT 
    Patient_Id,
    AES_DECRYPT(Patient_Health_Insu_No, 'encryption_key') AS Decrypted_Health_Insu_No
FROM 
    Patient_Health_INS_Table;

