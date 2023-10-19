-- Question 1
SELECT Name, Age
FROM Students
WHERE Major = 'Computer Science' AND Age > 20;

-- Question 2
SELECT S.Name, R.Grade
FROM Students S
JOIN Registrations R ON S.StudentID = R.StudentID
WHERE R.Grade = 'A';

-- Question 3
SELECT S.Name AS StudentName, C.CourseName, I.InstructorName
FROM Students S
JOIN Registrations R ON S.StudentID = R.StudentID
JOIN Courses C ON R.CourseID = C.CourseID
JOIN Instructors I ON C.InstructorID = I.InstructorID
WHERE S.Major = 'Computer Science';

-- Question 4
SELECT C.CourseName, I.InstructorName
FROM Courses C
JOIN Instructors I ON C.InstructorID = I.InstructorID;

-- Question 5
SELECT Name
FROM Students
WHERE StudentID NOT IN (SELECT DISTINCT StudentID FROM Registrations);

-- Question 6
SELECT S.Name
FROM Students S
JOIN Registrations R ON S.StudentID = R.StudentID
JOIN Courses C ON R.CourseID = C.CourseID
JOIN Instructors I ON C.InstructorID = I.InstructorID
WHERE S.Major = 'Computer Science' OR I.InstructorName = 'John Doe';

-- Question 7
SELECT S.Name
FROM Students S
JOIN Registrations R ON S.StudentID = R.StudentID
JOIN Courses C ON R.CourseID = C.CourseID
JOIN Instructors I ON C.InstructorID = I.InstructorID
WHERE S.Major = 'Computer Science' OR I.InstructorName = 'John Doe';

-- Question 8
SELECT S.Name
FROM Students S
LEFT JOIN Registrations R ON S.StudentID = R.StudentID
WHERE S.Major = 'Mathematics' AND R.StudentID IS NULL;

-- Question 9
SELECT DISTINCT C.CourseName
FROM Courses C
LEFT JOIN Instructors I ON C.InstructorID = I.InstructorID
WHERE C.DepartmentID IN (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Mathematics')
OR I.InstructorName = 'Jane Smith';

-- Question 10
SELECT Name
FROM Students
WHERE Age <= 20 AND Major IN ('Computer Science', 'Mathematics');

-- Question 11
SELECT C.CourseName
FROM Courses C
JOIN Instructors I ON C.InstructorID = I.InstructorID
WHERE C.Credits >= 3 AND C.DepartmentID IN (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Mathematics')
AND I.InstructorName <> 'Jane Smith';

-- Question 12
SELECT S.Name
FROM Students S
WHERE NOT EXISTS (
    SELECT C.CourseID
    FROM Courses C
    WHERE NOT EXISTS (
        SELECT R.CourseID
        FROM Registrations R
        WHERE R.StudentID = S.StudentID AND R.CourseID = C.CourseID
        AND C.InstructorID = (SELECT InstructorID FROM Instructors WHERE InstructorName = 'John Doe')
    )
);

-- Part B

SELECT W.WorkID, W.WorkName, W.Style, A.ArtistName
FROM WorksOfArt W
JOIN Artists A ON W.ArtistID = A.ArtistID
WHERE W.Style = 'Expressionist';

SELECT W.WorkID, W.WorkName, A.ArtistName
FROM WorksOfArt W
JOIN Artists A ON W.ArtistID = A.ArtistID
GROUP BY W.WorkID, W.WorkName, A.ArtistName
HAVING COUNT(*) >= 2;

SELECT C.CustomerName, T.TransactionID, W.WorkName, T.DateSold, T.SalesPrice
FROM Customers C
JOIN Transactions T ON C.CustomerID = T.CustomerID
JOIN WorksOfArt W ON T.WorkID = W.WorkID
WHERE YEAR(T.DateSold) = 2014;

SELECT W.WorkID, W.WorkName, A.ArtistName, W.AcquisitionPrice, W.AskingPrice
FROM WorksOfArt W
JOIN Artists A ON W.ArtistID = A.ArtistID
WHERE W.WorkID NOT IN (SELECT WorkID FROM Transactions WHERE DateSold IS NOT NULL);

SELECT YEAR(DatePurchased) AS PurchaseYear, SUM(AcquisitionPrice) AS TotalAcquisitionPrice
FROM WorksOfArt
GROUP BY YEAR(DatePurchased);

SELECT ArtistName, (YEAR(DeathDate) - YEAR(BirthDate)) AS AgeAtDeath
FROM Artists
WHERE DeathDate IS NOT NULL;

SELECT W.WorkName, (T.SalesPrice - W.AcquisitionPrice) AS Profit
FROM WorksOfArt W
JOIN Transactions T ON W.WorkID = T.WorkID
WHERE YEAR(T.DateSold) = 2014;

SELECT A.ArtistName, AVG(T.SalesPrice - W.AcquisitionPrice) AS AverageProfit
FROM WorksOfArt W
JOIN Transactions T ON W.WorkID = T.WorkID
JOIN Artists A ON W.ArtistID = A.ArtistID
GROUP BY A.ArtistName
ORDER BY AverageProfit DESC
LIMIT 1;

SELECT A.ArtistName, COUNT(T.WorkID) AS NumberOfWorksSold
FROM WorksOfArt W
JOIN Transactions T ON W.WorkID = T.WorkID
JOIN Artists A ON W.ArtistID = A.ArtistID
GROUP BY A.ArtistName
ORDER BY NumberOfWorksSold DESC
LIMIT 1;

SELECT C.CustomerName
FROM Customers C
 SELECT DISTINCT A.ArtistID
 FROM Artists A





