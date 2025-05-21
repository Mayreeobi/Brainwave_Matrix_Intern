-- DATABASE CREATION
DROP DATABASE IF EXISTS library_mgt;

-- Create Database For Auto Care
CREATE DATABASE library_mgt
DEFAULT CHARACTER SET utf8mb4;

-- Makes the database active
USE library_mgt;

-- TABLE CREATIONS

-- 1. Students Table
DROP TABLE IF EXISTS Students;
CREATE TABLE Students (
    StudentID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Phone VARCHAR(20) NOT NULL,
    DOB DATE,
    Email VARCHAR(150) UNIQUE CHECK (Email LIKE '%_@__%.__%')
);

-- 2. Authors
DROP TABLE IF EXISTS Authors;
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(255) NOT NULL
);

-- 3. Genre
DROP TABLE IF EXISTS Genres;
CREATE TABLE Genres (
    GenreID INT AUTO_INCREMENT PRIMARY KEY,
    GenreName VARCHAR(100)
);

-- 3. Books
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    AuthorID INT,
    GenreID INT,
    ISBN VARCHAR(20) UNIQUE CHECK (ISBN LIKE 'ISBN%' OR ISBN LIKE '978%' OR ISBN LIKE '979%'),
    PublishedYear YEAR,
    CopiesAvailable INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
);

-- 5. Borrowings
DROP TABLE IF EXISTS Borrowings;
CREATE TABLE Borrowings (
    BorrowID INT AUTO_INCREMENT PRIMARY KEY,
    StudentID INT,
    BookID INT,
    BorrowDate DATE,
    ReturnDate DATE NULL,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- 6. Staff (optional)
CREATE TABLE Staff (
    StaffID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(150),
    Role VARCHAR(50),
    Email VARCHAR(100),
    PasswordHash VARCHAR(255)
);

-- Constraints for Students Table
ALTER TABLE Students
     ADD CONSTRAINT CHK_Students_DOB_NotNull CHECK (DOB IS NOT NULL);

-- Constraints for Authors Table
ALTER TABLE Authors
     ADD CONSTRAINT CHK_Authors_FullName_NotNull CHECK (FullName IS NOT NULL);

-- Constraints for Books Table
ALTER TABLE Books
     ADD CONSTRAINT CHK_Books_Title_NotNull CHECK (Title IS NOT NULL);

     
-- INSERTING DATA INTO THE TABLES

-- Students
INSERT INTO Students (FirstName, LastName, Phone, DOB, Email)
VALUES 
('Mary', 'Johnson', '08031234567', '2023-01-10','maryj@gmail.com'),
('Ahmed', 'Bello', '07011234567', '2023-03-15', 'ahmedb@gmail.com'),
('Ngozi', 'Okafor', '08151234567', '2023-06-05', 'ngozi.o@gmail.com'), 
('Chinyere', 'Obasi', '08031234567', '1995-03-14', 'chinyere.obasi@example.com'),
('Busayo', 'Oke', '07098765432', '1992-07-22', 'busayo.oke@example.com'),
('James', 'Eze', '08145678901', '2000-01-11', 'james.eze@example.com'),
('Daniel', 'Ibrahim', '08023456789', '1995-03-24', 'danielib@gmail.com');


-- Authors
INSERT INTO Authors (FullName)
VALUES 
('Chimamanda Ngozi Adichie'),
('Chinua Achebe'),
('Wole Soyinka'),
('Ben Okri'),
('Sefi Atta'),
('Ngũgĩ wa Thiong\'o'),
('Nnedi Okorafor'),
('Teju Cole'),
('A. Igoni Barrett'),
('Aminatta Forna');


-- Genres
INSERT INTO Genres (GenreName)
VALUES 
('Fiction'),
('Drama'),
('History'),
('Science Fiction'),
('Biography'),
('Mystery'),
('Philosophy'),
('Poetry'),
('Self Help'),
('Romance');

-- Books
INSERT INTO Books (Title, AuthorID, GenreID, ISBN, PublishedYear, CopiesAvailable)
VALUES 
('Things Fall Apart', 1, 1, '9780385474542', 1958, 5),
('Death and the King’s Horseman', 2, 1, '9780435902298', 1975, 3),
('Half of a Yellow Sun', 3, 1, '9780007200283', 2006, 4),
('The Famished Road', 4, 1, 'ISBN978-0000000001', 1991, 6),
('Everything Good Will Come', 5, 7, 'ISBN978-0000000002', 2005, 4),
('Petals of Blood', 6, 3, 'ISBN978-0000000003', 1977, 5),
('Who Fears Death', 7, 1, 'ISBN978-0000000004', 2010, 2),
('Open City', 8, 5, 'ISBN978-0000000005', 2011, 3),
('Blackass', 9, 4, 'ISBN978-0000000006', 2015, 1),
('The Memory of Love', 10, 6, 'ISBN978-0000000007', 2010, 2);


-- Borrowings
INSERT INTO Borrowings (StudentID, BookID, BorrowDate, ReturnDate)
VALUES 
(1, 1, '2025-01-05', '2025-01-15'),
(2, 2, '2025-01-05', '2025-01-20'),
(3, 3, '2025-02-08', '2025-02-22'),
(1, 4, '2025-04-01', NULL),
(2, 6, '2025-03-03', '2025-03-27'),
(2, 8, '2025-03-20', '2025-04-02'),
(1, 7, '2025-05-02', NULL),
(3, 5, '2025-04-30', NULL),
(3, 9, '2025-03-25', NULL),
(1, 10, '2025-03-10', NULL); 

-- TO BE SURE THE DATA WAS SUCCESSFULLY INSERTED INTO THE TABLES
SELECT * FROM Students;
SELECT * FROM Authors;
SELECT * FROM Genres;
SELECT * FROM Books;
SELECT * FROM Borrowings;

# QUERY OPTIMIZATION #
-- Creating indexes for performance optimization
CREATE INDEX idx_students_phone ON Students(Phone);
CREATE INDEX idx_books_authorid ON Books(AuthorID);
CREATE INDEX idx_books_genreid ON Books(GenreID);
CREATE INDEX idx_genres_genrename ON Genres(GenreName);
CREATE INDEX idx_borrowings_studentid ON Borrowings(StudentID);
CREATE INDEX idx_borrowings_bookid ON Borrowings(BookID);
CREATE INDEX idx_borrowings_returndate ON Borrowings(ReturnDate);

/*
idx_students_phone: Index on Phone for faster lookups and filtering.
Indexes on the books table: Indexes on foreign keys for join optimization
idx_genres_genrename: This index speeds up searches by genre name.
Indexes on the books table: Indexes on foreign keys and ReturnDate for filtering.
*/


-- 1. Which books are currently borrowed and not yet returned?
SELECT 
    b.BookID, b.Title, s.StudentID, 
    CONCAT(s.FirstName, ' ', s.LastName) AS FullName, br.BorrowDate 
FROM 
    Borrowings br
JOIN 
    Books b ON br.BookID = b.BookID
JOIN 
    Students s ON br.StudentID = s.StudentID
WHERE 
    br.ReturnDate IS NULL;

-- 2. How many books has each student borrowed?
SELECT 
    s.StudentID, 
    CONCAT(s.FirstName, ' ', s.LastName) AS FullName,
    COUNT(br.BookID) AS TotalBooksBorrowed
FROM 
    Students s
LEFT JOIN 
    Borrowings br ON s.StudentID = br.StudentID
GROUP BY 
    s.StudentID, FullName;

-- 3. Who are the top 5 students that borrowed the most books?
SELECT 
    s.StudentID, 
    CONCAT(s.FirstName, ' ', s.LastName) AS FullName,
    COUNT(br.BookID) AS TotalBooksBorrowed
FROM 
    Students s
JOIN 
    Borrowings br ON s.StudentID = br.StudentID
GROUP BY 
    s.StudentID, FullName
ORDER BY 
    TotalBooksBorrowed DESC
LIMIT 5;

-- 4. Which books have never been borrowed?
SELECT 
    b.BookID, b.Title 
FROM 
    Books b
LEFT JOIN 
    Borrowings br ON b.BookID = br.BookID
WHERE 
    br.BorrowID IS NULL;
    
-- 5. What is the average borrow duration for returned books?
SELECT 
    AVG(DATEDIFF(ReturnDate, BorrowDate)) AS AvgBorrowDuration
FROM 
    Borrowings
WHERE 
    ReturnDate IS NOT NULL;

-- 6. List all books by genre with the number of times they’ve been borrowed
SELECT 
    g.GenreName, b.Title, COUNT(br.BorrowID) AS TimesBorrowed
FROM 
    Books b
JOIN 
    Genres g ON b.GenreID = g.GenreID
LEFT JOIN 
    Borrowings br ON b.BookID = br.BookID
GROUP BY 
    g.GenreName, b.Title
ORDER BY 
    g.GenreName, TimesBorrowed DESC;

-- 7. How many books has each author written?
SELECT 
    a.AuthorID, a.FullName, COUNT(b.BookID) AS BooksWritten
FROM 
    Authors a
LEFT JOIN 
    Books b ON a.AuthorID = b.AuthorID
GROUP BY 
    a.AuthorID, a.FullName;



-- Staff (optional)
INSERT INTO Staff (FullName, Role, Email, PasswordHash)
VALUES 
('Grace Umeh', 'Librarian', 'grace.umeh@example.com', SHA2('Grace123!', 256)),
('Tunde Bakare', 'Assistant Librarian', 'tunde.bakare@example.com', SHA2('Tunde456!', 256)),
('Ngozi Okafor', 'Admin', 'ngozi.okafor@example.com', SHA2('Ngozi789!', 256)),
('Ibrahim Musa', 'Cataloguer', 'ibrahim.musa@example.com', SHA2('Ibrahim321!', 256)),
('Fatima Ahmed', 'Archivist', 'fatima.ahmed@example.com', SHA2('Fatima654!', 256)),
('Daniel Etim', 'Technical Support', 'daniel.etim@example.com', SHA2('Daniel987!', 256)),
('Chika Nwosu', 'Circulation Desk', 'chika.nwosu@example.com', SHA2('Chika246!', 256));

-- View: All Borrowed Books with Student Info
CREATE VIEW vw_BorrowedBooks AS
SELECT 
    br.BorrowID,
    s.FirstName,
    s.LastName,
    b.Title,
    br.BorrowDate,
    br.ReturnDate
FROM Borrowings br
JOIN Students s ON br.StudentID = s.StudentID
JOIN Books b ON br.BookID = b.BookID;

-- For reusable reports like:
CREATE VIEW CurrentBorrowedBooks AS
SELECT s.FirstName, s.LastName, b.Title, br.BorrowDate
FROM Borrowings br
JOIN Students s ON br.StudentID = s.StudentID
JOIN Books b ON br.BookID = b.BookID
WHERE br.ReturnDate IS NULL;

-- Stored Procedures for Library Management
-- Borrow a Book: Checks availability, updates inventory, and inserts a borrow record.
DELIMITER //

CREATE PROCEDURE BorrowBook (
    IN p_StudentID INT,
    IN p_BookID INT,
    IN p_BorrowDate DATE
)
BEGIN
    DECLARE available INT;

    SELECT CopiesAvailable INTO available
    FROM Books
    WHERE BookID = p_BookID;

    IF available > 0 THEN
        -- Insert borrowing record
        INSERT INTO Borrowings (StudentID, BookID, BorrowDate)
        VALUES (p_StudentID, p_BookID, p_BorrowDate);

        -- Decrease available copies
        UPDATE Books
        SET CopiesAvailable = CopiesAvailable - 1
        WHERE BookID = p_BookID;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No copies available for this book.';
    END IF;
END //

DELIMITER ;

-- Return a Book: Updates the return date and increases the book's available copies
DELIMITER //

CREATE PROCEDURE ReturnBook (
    IN p_BorrowID INT,
    IN p_ReturnDate DATE
)
BEGIN
    DECLARE bookID INT;

    SELECT BookID INTO bookID
    FROM Borrowings
    WHERE BorrowID = p_BorrowID;

    -- Update return date
    UPDATE Borrowings
    SET ReturnDate = p_ReturnDate
    WHERE BorrowID = p_BorrowID;

    -- Increase available copies
    UPDATE Books
    SET CopiesAvailable = CopiesAvailable + 1
    WHERE BookID = bookID;
END //

DELIMITER ;

-- Lists of books by genre
DELIMITER //

CREATE PROCEDURE GetBooksByGenre (
    IN p_GenreName VARCHAR(100)
)
BEGIN
    SELECT b.Title, a.FullName AS Author, g.GenreName
    FROM Books b
    JOIN Authors a ON b.AuthorID = a.AuthorID
    JOIN Genres g ON b.GenreID = g.GenreID
    WHERE g.GenreName = p_GenreName;
END //

DELIMITER ;

--  Trigger: Prevent Borrowing When No Copies Available
DELIMITER $$

CREATE TRIGGER trg_BeforeBorrowing
BEFORE INSERT ON Borrowings
FOR EACH ROW
BEGIN
    DECLARE copies INT;
    SELECT CopiesAvailable INTO copies FROM Books WHERE BookID = NEW.BookID;
    
    IF copies < 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No copies available for this book.';
    END IF;
END$$

DELIMITER ;


