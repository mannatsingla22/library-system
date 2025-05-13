-- Step 1: Create a new database
CREATE DATABASE IF NOT EXISTS LibraryDB;

-- Step 2: Use the database
USE LibraryDB;


CREATE TABLE Member (  
MemberID INT PRIMARY KEY,  
FirstName VARCHAR(50),  
LastName VARCHAR(50),  
Email VARCHAR(100),  
Phone VARCHAR(15),  
MemberType ENUM('Student', 'Professor', 'Staff') NOT NULL  
);  
CREATE TABLE Books (  
BookID INT PRIMARY KEY,  
Title VARCHAR(100),  
Author VARCHAR(100),  
Category VARCHAR(50),  
AvailableCopies INT  
);  
CREATE TABLE Staff (  
StaffID INT PRIMARY KEY,  
MemberID INT,  -- References the Member table  
FOREIGN KEY (MemberID) REFERENCES Member(MemberID)  
);  
CREATE TABLE Borrowings (  
BorrowingID INT PRIMARY KEY,  
MemberID INT,  
BookID INT,  
BorrowDate DATE,  
ReturnDate DATE,  
FOREIGN KEY (MemberID) REFERENCES Member(MemberID), 
FOREIGN KEY (BookID) REFERENCES Books(BookID)  
);  
CREATE TABLE Fines (  
FineID INT PRIMARY KEY,  
BorrowingID INT,  
FineAmount DECIMAL(10, 2),  
Paid BOOLEAN DEFAULT FALSE,  
FOREIGN KEY (BorrowingID) REFERENCES Borrowings(BorrowingID)  
);  
CREATE TABLE BookCategories (  
CategoryID INT PRIMARY KEY,  
CategoryName VARCHAR(50)  
);  
INSERT INTO BookCategories (CategoryID, CategoryName)  
VALUES   
(1, 'Fiction'),  
(2, 'Non-Fiction'),  
(3, 'Science'),  
(4, 'History'),  
(5, 'Biography'), 
(6, 'Self-Help'),  
(7, 'Technology'),  
(8, 'Indian Literature');  
INSERT INTO Books (BookID, Title, Author, Category, AvailableCopies)  
VALUES   
(101, 'The Great Gatsby', 'F. Scott Fitzgerald', 1, 3),  
(102, 'To Kill a Mockingbird', 'Harper Lee', 1, 5),  
(103, 'A Brief History of Time', 'Stephen Hawking', 3, 2),  
(104, 'The Alchemist', 'Paulo Coelho', 1, 4),  
(105, 'Sapiens: A Brief History of Humankind', 'Yuval Noah Harari', 4, 3),  
(106, '1984', 'George Orwell', 1, 2),  
(107, 'Wings of Fire', 'A.P.J. Abdul Kalam', 8, 2),  
(108, 'The God of Small Things', 'Arundhati Roy', 8, 4),  
(109, 'The Guide', 'R.K. Narayan', 8, 1),  
(110, 'Think and Grow Rich', 'Napoleon Hill', 6, 5),  
(111, 'You Can Win', 'Shiv Khera', 6, 3),  
(112, 'Clean Code', 'Robert C. Martin', 7, 7),  
(113, 'Rich Dad Poor Dad', 'Robert T. Kiyosaki', 6, 6),  
(114, 'My Experiments with Truth', 'Mahatma Gandhi', 5, 3),  
(115, 'India After Gandhi', 'Ramachandra Guha', 4, 2),  
(116, 'The Theory of Everything', 'Stephen Hawking', 3, 3),  
(117, 'The Discovery of India', 'Jawaharlal Nehru', 4, 2),  
(118, 'The Secret', 'Rhonda Byrne', 6, 4),  
(119, 'Ikigai', 'Héctor García', 6, 3),  
(120, 'The Power of Habit', 'Charles Duhigg', 6, 5);  
INSERT INTO Member (MemberID, FirstName, LastName, Email, Phone, MemberType)  
VALUES   
(1, 'John', 'Doe', 'john.doe@email.com', '1234567890', 'Student'),  
(2, 'Jane', 'Smith', 'jane.smith@email.com', '9876543210', 'Professor'),  
(3, 'Mike', 'Johnson', 'mike.johnson@email.com', '5555555555', 'Staff'),  
(4, 'Aarav', 'Sharma', 'aarav.sharma@email.com', '9876543211', 'Student'),  
(5, 'Priya', 'Kapoor', 'priya.kapoor@email.com', '9123456789', 'Professor'), 
(6, 'Kavya', 'Nair', 'kavya.nair@email.com', '9234567891', 'Student'),  
(7, 'Aditya', 'Joshi', 'aditya.joshi@email.com', '9345678901', 'Staff'),  
(8, 'Rohan', 'Mehta', 'rohan.mehta@email.com', '9456789012', 'Professor');  
INSERT INTO Staff (StaffID, MemberID)  
VALUES   
(1, 3),  
(2, 7),  
(3, 8);  
INSERT INTO Borrowings (BorrowingID, MemberID, BookID, BorrowDate, ReturnDate)  
VALUES   
(1, 1, 101, '2024-11-01', NULL),  -- John borrowing 'The Great Gatsby'  
(2, 2, 102, '2024-11-03', NULL),  -- Jane borrowing 'To Kill a Mockingbird'  
(3, 4, 107, '2024-11-01', NULL),  -- Aarav borrowing 'Wings of Fire'  
(4, 5, 108, '2024-11-05', NULL),  -- Priya borrowing 'The God of Small Things'  
(5, 6, 109, '2024-10-25', '2024-11-05'),  -- Kavya returning 'The Guide'  
(6, 7, 111, '2024-11-10', NULL),  -- Aditya borrowing 'You Can Win'  
(7, 8, 114, '2024-10-15', '2024-10-25'),  -- Rohan borrowing Gandhi's autobiography  
(8, 1, 103, '2024-11-12', NULL);  -- John borrowing 'A Brief History of Time'  
INSERT INTO Fines (FineID, BorrowingID, FineAmount, Paid)  
VALUES   
(1, 1, 50.00, FALSE), -- Fine for John  
(2, 2, 30.00, FALSE), -- Fine for Jane  
(3, 3, 20.00, FALSE), -- Fine for Aarav  
(4, 4, 40.00, FALSE), -- Fine for Priya  
(5, 5, 0.00, TRUE),   -- No fine for Kavya  
(6, 6, 20.00, FALSE), -- Fine for Aditya  
(7, 7, 10.00, TRUE),  -- Paid fine for Rohan  
(8, 8, 0.00, TRUE);   -- No fine for John (on second borrowing)  
SELECT b.BorrowingID, b.BorrowDate, b.ReturnDate, bo.Title, bo.Author 
FROM Borrowings b 
JOIN Books bo ON b.BookID = bo.BookID 
WHERE b.MemberID = 1; -- Replace 1 with the desired MemberID 
SELECT b.BorrowingID, m.FirstName, m.LastName, bo.Title, b.BorrowDate 
FROM Borrowings b 
JOIN Member m ON b.MemberID = m.MemberID 
JOIN Books bo ON b.BookID = bo.BookID 
WHERE b.ReturnDate IS NULL AND b.BorrowDate < DATE_SUB(CURDATE(), INTERVAL 15 
DAY); 
SELECT m.MemberID, m.FirstName, m.LastName, f.FineAmount 
FROM Member m 
JOIN Borrowings b ON m.MemberID = b.MemberID 
JOIN Fines f ON b.BorrowingID = f.BorrowingID 
WHERE f.Paid = FALSE; 
SELECT bo.Title, bo.Author, bc.CategoryName, m.FirstName, m.LastName, b.BorrowDate 
FROM Borrowings b 
JOIN Books bo ON b.BookID = bo.BookID 
JOIN BookCategories bc ON bo.Category = bc.CategoryID 
JOIN Member m ON b.MemberID = m.MemberID 
WHERE bc.CategoryName = 'Science'; -- Replace 'Science' with the desired category 
SELECT m.MemberID, m.FirstName, m.LastName, SUM(f.FineAmount) AS OutstandingFines 
FROM Member m 
JOIN Borrowings b ON m.MemberID = b.MemberID 
JOIN Fines f ON b.BorrowingID = f.BorrowingID 
WHERE m.MemberID = 1 AND f.Paid = FALSE  -- Replace 1 with the Student's MemberID 
GROUP BY m.MemberID, m.FirstName, m.LastName; 
SELECT b.BorrowingID, bo.Title, bo.Author, b.BorrowDate,  
DATE_ADD(b.BorrowDate, INTERVAL 15 DAY) AS DueDate 
FROM Borrowings b 
JOIN Books bo ON b.BookID = bo.BookID 
WHERE b.MemberID = 1 AND b.ReturnDate IS NULL; -- Replace 1 with the Student's MemberID 
SELECT b.BorrowingID, bo.Title,  
DATEDIFF(CURDATE(), DATE_ADD(b.BorrowDate, INTERVAL 15 DAY)) AS OverdueDays,  
CASE  
WHEN DATEDIFF(CURDATE(), DATE_ADD(b.BorrowDate, INTERVAL 15 DAY)) > 0  
THEN DATEDIFF(CURDATE(), DATE_ADD(b.BorrowDate, INTERVAL 15 DAY)) * 5  
ELSE 0  
END AS FineAmount 
FROM Borrowings b 
JOIN Books bo ON b.BookID = bo.BookID 
WHERE b.MemberID = 1 AND b.ReturnDate IS NULL; -- Replace 1 with the Student's MemberID 
SELECT Title, Author, AvailableCopies  
FROM Books  
WHERE Title LIKE '%The Great Gatsby%'; -- Replace with the desired book title 
SELECT bo.Title, bo.Author, COUNT(b.BorrowingID) AS BorrowCount 
FROM Borrowings b 
JOIN Books bo ON b.BookID = bo.BookID 
JOIN Member m ON b.MemberID = m.MemberID 
WHERE m.MemberType = 'Student' 
GROUP BY bo.Title, bo.Author 
ORDER BY BorrowCount DESC 
LIMIT 5; 
SELECT m.MemberID, m.FirstName, m.LastName, COUNT(b.BorrowingID) AS TotalBorrowed 
FROM Member m 
JOIN Borrowings b ON m.MemberID = b.MemberID 
GROUP BY m.MemberID, m.FirstName, m.LastName 
ORDER BY TotalBorrowed DESC; 
SELECT bo.Title, bo.Author, COUNT(b.BorrowingID) AS BorrowCount,  
MONTH(b.BorrowDate) AS Month 
FROM Borrowings b 
JOIN Books bo ON b.BookID = bo.BookID 
GROUP BY bo.Title, bo.Author, MONTH(b.BorrowDate) 
ORDER BY BorrowCount DESC;