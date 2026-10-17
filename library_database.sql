-- =====================================================
-- Project: Library Database
-- Exercise 1: SQL Fundamentals
-- Description: Create and manage a library database
-- using Microsoft SQL Server / T-SQL.
-- =====================================================

-- IMPORTANT:
-- This script is intended for a fresh SQL Server database setup.
-- It creates LibraryDB, inserts sample data, performs updates/deletes,
-- and changes the table definitions. It is not idempotent and should not
-- be run repeatedly without resetting or removing the existing database.

-- =====================================================
-- Part 1: Create and Select the Database
-- =====================================================

-- Create a new database for the library management system.
CREATE DATABASE LibraryDB;
GO

-- Select the database to use in the following operations.
USE LibraryDB;
GO

-- =====================================================
-- Part 2: Create Tables
-- =====================================================

-- Create the Categories table to store book categories.
CREATE TABLE Categories
(
    CategoryID INT IDENTITY(1, 1) PRIMARY KEY,
    CategoryName NVARCHAR(50) NOT NULL UNIQUE,
    Description NVARCHAR(150) NULL
);

-- Create the Books table to store book information.
CREATE TABLE Books
(
    BookID INT IDENTITY(1, 1) PRIMARY KEY,
    CategoryID INT NOT NULL,
    Title NVARCHAR(100) NOT NULL,
    AuthorName NVARCHAR(60) NOT NULL,
    Price DECIMAL(14, 2) NOT NULL,
    PublishDate DATE NULL,
    Quantity INT NOT NULL,
    IsAvailable BIT DEFAULT (1),

    -- Link each book to an existing category.
    CONSTRAINT category_id_fk
        FOREIGN KEY (CategoryID)
        REFERENCES Categories (CategoryID),

    -- Ensure that each book has a positive price.
    CONSTRAINT price_check CHECK (Price > 0),

    -- Prevent negative book quantities.
    CONSTRAINT quantity_check CHECK (Quantity >= 0)
);
GO

-- =====================================================
-- Part 3: Insert Sample Data
-- =====================================================

-- Insert sample categories into the Categories table.
INSERT INTO Categories (CategoryName, Description)
VALUES
    (N'Programming', N'Programming and software development books'),
    (N'Databases', N'Database design and SQL books'),
    (N'Networks', N'Computer networking books'),
    (N'Artificial Intelligence', N'AI and machine learning books');

-- Insert sample books into the Books table.
-- Each book is associated with a category using CategoryID.
INSERT INTO Books
    (CategoryID, Title, AuthorName, Price, PublishDate, Quantity)
VALUES
    (1, N'Python Basics', N'Ahmed Ali', 450.00, '2023-05-15', 10),
    (1, N'C# Fundamentals', N'Mona Hassan', 550.00, '2022-09-10', 6),
    (2, N'SQL Server Fundamentals', N'Sara Hassan', 600.00, '2024-01-20', 7),
    (2, N'Database Design', N'Omar Adel', 480.00, '2021-11-05', 5),
    (3, N'Computer Networks', N'Khaled Samir', 520.00, '2020-07-18', 4),
    (3, N'Network Security', N'Hany Mostafa', 680.00, '2023-03-25', 3),
    (4, N'Introduction to AI', N'Nour Ahmed', 750.00, '2024-02-12', 8),
    (4, N'Machine Learning Basics', N'Salma Ali', 820.00, '2023-10-08', 5);
GO

-- =====================================================
-- Part 4: Update Records
-- =====================================================

-- Query 1: Update the price of 'Python Basics' to 500.
UPDATE Books
SET Price = 500
WHERE Title = N'Python Basics';

-- Query 2: Increase the prices of books in category 2 by 100.
UPDATE Books
SET Price = Price + 100
WHERE CategoryID = 2;

-- Query 3: Set the quantity of 'Computer Networks' to zero.
UPDATE Books
SET Quantity = 0
WHERE Title = N'Computer Networks';

-- Query 4: Move 'C# Fundamentals' to category 4.
UPDATE Books
SET CategoryID = 4
WHERE Title = N'C# Fundamentals';

-- =====================================================
-- Part 5: Delete Records
-- =====================================================

-- Query 5: Delete the book titled 'Network Security'.
DELETE FROM Books
WHERE Title = N'Network Security';

-- Query 6: Delete the book whose BookID is 4.
DELETE FROM Books
WHERE BookID = 4;

-- =====================================================
-- Part 6: Alter Tables
-- =====================================================

-- Query 7: Add an ISBN column to the Books table.
ALTER TABLE Books
ADD ISBN NVARCHAR(20);

-- Query 8: Add a Publisher column to the Books table.
ALTER TABLE Books
ADD Publisher NVARCHAR(60);

-- Query 9: Add a FloorNumber column to the Categories table.
ALTER TABLE Categories
ADD FloorNumber INT;

-- Query 10: Increase the maximum length of the Publisher column
-- from NVARCHAR(60) to NVARCHAR(100).
ALTER TABLE Books
ALTER COLUMN Publisher NVARCHAR(100);
