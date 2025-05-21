# Library Management System 
- Click [Here](https://github.com/Mayreeobi/Database-Creation/blob/main/librarymgt.sql) for the SQL script

The Library Management System is designed to streamline and automate the processes involved in managing a library’s operations, including book tracking, student borrowing records, and author/genre categorization. This system ensures efficient book inventory management, real-time tracking of borrowed and returned books, and easy retrieval of student borrowing history. It improves the accuracy of record keeping, supports quick decision-making for acquisitions, and provides an organized structure for maintaining book-related data.

### Objectives:
The core objective of the system is to:
    -  Manage and organize a large collection of books
    -  Track which books are issued, returned, or overdue
    -  Record information about students and their borrowing history
    -  Categorize books by genre and author
    -  Facilitate queries for library staff and users

### Database Structure
The Library Management System is built on a relational database model. It consists of the following core tables:
 1. 📚 Students: Holds information about students who borrow books.
 2. 📖 Books: Stores details of books available in the library.
 3. ✍️ Authors: Stores information about authors of books.
 4. 🏷️ Genres: Holds the genres or categories of books.
 5. 📅 Borrowings: Tracks the borrowing and returning of books.

### 🧩 Entity Relationships
   - One-to-Many: One student can borrow multiple books.
   - Many-to-One: Each book is written by one author and belongs to one genre.
   - One-to-Many: One author can write multiple books.
   - One-to-Many: One genre can include multiple books.







# Hospital Management System
- Click [Here](https://github.com/Mayreeobi/Database-Creation/blob/main/HosptialMgt_db.sql) for the SQL script
  
Welcome to the design for your Hospital Management Database! This document outlines the structure of a relational database system designed to efficiently manage key operations within a hospital environment. From patient records and doctor details to appointments, prescriptions, and payments, this database aims to provide a centralized and organized way to store and retrieve critical information, supporting better administrative processes and patient care.

The goal is to create a robust and interconnected system that allows for easy tracking of patient journeys, doctor schedules, medication dispensing, and financial transactions.

### Database Structure
The HospitalMgt_db database is composed of several interconnected tables, each serving a specific purpose. Relationships between tables are established using primary and foreign keys to ensure data integrity and enable complex queries.
Here's a breakdown of each table:

1. 🏢 Departments Table: Stores information about the various departments within the hospital.
2. 🩺 Doctors Table: Contains information about the medical doctors and their specialties.
3. 👨‍⚕️ Patients Table: Stores demographic and contact information for all registered patients who receive medical care.
4. 📅 Appointments Table: Tracks appointments scheduled between patients and doctors.
5. 💊 Medications Table: Lists all available medications in the hospital.
6. 📝 Prescriptions Table: Records medications prescribed during an appointment.
7. 💳 Payments Table: Manages billing and payment information related to services rendered.


### 🧩 Entity Relationships
   - One-to-Many: One department can have many doctors.
   - One-to-Many: One doctor can have many appointments.
   - One-to-Many: One patient can have many appointments and payments.
   - Many-to-Many: Appointments and Medications are linked through Prescriptions.

This structure provides a solid foundation for managing the core data of a hospital, allowing for efficient record-keeping and reporting.
