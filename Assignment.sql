-- Step 1: Create & connect to database 
CREATE DATABASE school_db; \c school_db;
-- Step 2: students table 

CREATE TABLE students 
( student_id SERIAL PRIMARY KEY,
name VARCHAR(100) NOT NULL, 
age INT, gender VARCHAR(10),
city VARCHAR(50),
enrollment_date DATE );

-- Step 3: subjects table 

CREATE TABLE subjects (
subject_id SERIAL PRIMARY KEY, 
subject_name VARCHAR(100) NOT NULL, 
teacher_name VARCHAR(100), max_marks INT );

-- Step 4: grades table (connects students + subjects)

CREATE TABLE grades (
grade_id SERIAL PRIMARY KEY,
student_id INT REFERENCES students(student_id), 
subject_id INT REFERENCES subjects(subject_id), 
marks_obtained INT, exam_date DATE );

-- INSERT INTO students 

INSERT INTO students (name, age, gender, city, enrollment_date) 
VALUES ('Aarav Sharma', 17, 'Male', 'Delhi', '2023-04-01'),
('Priya Gupta', 16, 'Female', 'Mumbai', '2023-04-03'), 
('Rahul Verma', 18, 'Male', 'Delhi', '2022-06-15'), 
('Sneha Patel', 15, 'Female', 'Lucknow', '2023-07-20'),
('Amit Singh', 17, 'Male', 'Jaipur', '2022-09-10'), 
('Divya Nair', 16, 'Female', 'Chennai', '2023-01-05'), 
('Karan Mehta', 18, 'Male', 'Delhi', '2021-11-22'),
('Anjali Yadav', 15, 'Female', 'Lucknow', '2023-03-18'), 
('Vikram Joshi', 17, 'Male', 'Mumbai', '2022-08-30'), 
('Neha Tiwari', 16, 'Female', 'Delhi', '2023-05-14');

-- INSERT INTO subjects 

INSERT INTO subjects (subject_name, teacher_name, max_marks) 
VALUES ('Mathematics', 'Mr. Rajesh Kumar', 100),
('Science', 'Mrs. Sunita Sharma', 100), 
('English', 'Mr. Anil Verma', 80), 
('History', 'Mrs. Pooja Mishra', 80), 
('Computer', 'Mr. Deepak Singh', 100);

-- INSERT INTO grades 

INSERT INTO grades (student_id, subject_id, marks_obtained, exam_date)
VALUES (1,1,88,'2024-03-10'), 
(1,2,76,'2024-03-11'), 
(1,3,65,'2024-03-12'), 
(2,1,92,'2024-03-10'),
(2,3,78,'2024-03-12'),
(2,5,95,'2024-03-14'),
(3,2,55,'2024-03-11'),
(3,4,60,'2024-03-13'),
(3,5,70,'2024-03-14'),
(4,1,45,'2024-03-10'), 
(4,2,50,'2024-03-11'), 
(4,3,38,'2024-03-12'),
(5,1,80,'2024-03-10'), 
(5,4,74,'2024-03-13'),
(5,5,88,'2024-03-14'),
(6,2,91,'2024-03-11'),
(6,3,83,'2024-03-12'),
(6,5,97,'2024-03-14'),
(7,1,33,'2024-03-10'),
(7,2,40,'2024-03-11'),
(7,4,28,'2024-03-13'), 
(8,1,72,'2024-03-10'), 
(8,3,68,'2024-03-12'), 
(8,5,85,'2024-03-14'), 
(9,2,60,'2024-03-11'), 
(9,4,55,'2024-03-13'),
(9,5,78,'2024-03-14'),
(10,1,95,'2024-03-10'),
(10,2,90,'2024-03-11'),
(10,5,99,'2024-03-14'); 
-- SECTION A

-- Q1(a) Retrieve the name, age, and city of all students who are from 'Delhi' and older than 16 years. 
-- Sort the result by name in ascending order.
SELECT name,age,city
FROM students
WHERE city='DELHI' AND age>16
ORDER BY name ASC;

-- (B) Display all distinct cities from which students have enrolled.
SELECT city
FROM students;;

-- (c) Fetch the complete details of all female students.
SELECT FEMALE
FROM students
WHERE  gender='Female';

-- (D)) List all students who enrolled after 1st January 2023, ordered by enrollment_date in descending order
SELECT *
FROM students
WHERE enrollment_date>'2023-01-01'
ORDER BY enrollment_date DESC;

-- (e) Show all students whose age is between 15 and 18 (inclusive).

--Q2(a) Retrieve the name and city of all students whose name starts with 'A'.
SELECT name,city
FROM students
WHERE name LIKE 'A%' ;

-- (B) Find all students whose city ends with the letter 'i'.
SELECT *
FROM students
WHERE city LIKE '%i';

-- (C)Display all distinct gender values present in the table.
SELECT gender
FROM students
GROUP BY gender;

-- (D) List students whose name contains the word 'Kumar' anywhere.
SELECT *
FROM students
WHERE name LIKE '%Kumar%';

-- (E)) Retrieve the first 5 students (by student_id) from the table.
SELECT *
FROM students
LIMIT 5;

-- Q3(A)Retrieve all subjects where max_marks is 100. 
SELECT * 
FROM students s
JOIN grades g
ON s.student_id=g.grade_id
JOIN subjects c
ON c.subject_id=g.subject_id
WHERE c.max_marks = 100;

-- (B) Display subject_name and teacher_name sorted alphabetically by subject_name. 
SELECT subject_name,teacher_name
FROM subjects
ORDER BY subject_name ;

-- (C) Find all subjects taught by teachers whose name starts with 'Mr.'.
SELECT *
FROM subjects
WHERE teacher_name LIKE 'Mr.%';

-- (D) List all subjects where max_marks is less than 100.
SELECT *
FROM subjects
WHERE max_marks<100;

-- (E) Show all distinct max_marks values available in the subjects table.
SELECT DISTINCT max_marks
FROM subjects;

-- Q4(A)) Retrieve all grade records where marks_obtained > 80.
SELECT *
FROM grades
WHERE marks_obtained >80;

-- (B) Display all records where marks_obtained < 50 (failing students).
SELECT *
FROM grades
WHERE marks_obtained < 50;

-- (C) Fetch all grade records for exam_date '2024-03-10'.
SELECT *
FROM grades
WHERE exam_date = '2024-03-10';

-- (D) List all grade records where marks_obtained is between 60 and 90.
SELECT *
FROM grades
WHERE marks_obtained BETWEEN 60 AND 90;

-- (E) Show all grade records ordered by marks_obtained descending. Display only the top 5.
SELECT *
FROM grades
ORDER BY marks_obtained DESC
LIMIT 5;

-- Q5(A)Retrieve the name and enrollment_date of the 3 most recently enrolled students.  
SELECT name, emrollment_date
FROM students


-- (B) Display all male students from 'Delhi', sorted by age descending. 
SELECT *
FROM students
WHERE gender='Male' AND city ='Delhi'
ORDER BY age DESC;

-- (C) List all students whose age is NOT 17.
SELECT *
FROM students
WHERE age <> 17;

-- (D) Show students from either 'Mumbai' or 'Lucknow'.
SELECT *
FROM students
WHERE city IN ('Mumbai','Lucknow');

-- (E) Write a query to display all students where city is NULL.
SELECT *
FROM students
WHERE city IS null;

-- 	Q6(a) Find the total number of grade records in the table.							SECTION B
SELECT sum(student_id) AS totalGrade
FROM grades;

-- (B)  Calculate the average marks_obtained across all records.
SELECT AVG(marks_obtained) AS average
FROM grades;

-- (C)Find the highest marks_obtained in the entire table
SELECT max(marks_obtained)
FROM grades;

-- (D)Find the lowest marks_obtained in the entire table.
SELECT min(marks_obtained)
FROM grades;

-- (E) Calculate the sum of marks_obtained for student_id = 2.
SELECT sum(marks_obtained)
FROM grades
WHERE student_id=2;

-- Q7(a) Find the total marks scored by each student (group by student_id).
SELECT sum(marks_obtained)
FROM grades
GROUP BY student_id;

-- (b)  Find the average marks scored per subject (group by subject_id).
SELECT AVG(marks_obtained)
FROM grades
GROUP BY student_id;

-- (C)Count how many exams each student has appeared in.
SELECT student_id, count(*)
FROM grades
GROUP BY student_id;

-- (d) Find the maximum marks scored by each student across all subjects.
SELECT student_id, max(marks_obtained) AS marks
FROM grades
GROUP BY subject_id;

-- (e) Find the minimum marks scored in each subject.
SELECT min(marks_obtained)
FROM grades
GROUP BY subject_id;

-- Q8(a)Find all students whose total marks are greater than 200.
SELECT s.name
FROM students s
JOIN grades g
ON g.student_id=s.student_id
GROUP BY s.student_id
HAVING SUM(g.marks_obtained) >200;

-- (b) Find subjects where the average marks are above 70.
SELECT s.subject_name
FROM subjects s
JOIN grades g
ON s.subject_id=g.subject_id
GROUP BY s.subject_id
HAVING AVG(marks_obtained)>70;

-- (c) List students who have appeared in more than 2 exams.
SELECT s.student_id,s.name
FROM grades g
JOIN students s
ON s.student_id=g.student_id
GROUP BY s.student_id, s.name
HAVING count(*)>2;

-- (d) Find subjects where the maximum marks scored is greater than 90.
SELECT s.subject_id,s.subject_name
FROM grades g
JOIN subjects s
ON g.subject_id=s.subject_id
GROUP BY s.subject_id
HAVING max(marks_obtained)>90;

-- (e)Find students whose average marks across all subjects is less than 60.
SELECT s.student_id,s.name
FROM grades g
JOIN students s
ON s.student_id=g.student_id
GROUP BY s.student_id
HAVING  AVG(marks_obtained) <60;

-- Q9(a) Count the total number of subjects available.
SELECT COUNT(subject_id)
FROM subjects


-- (b) Find the average max_marks across all subjects.
SELECT AVG(max_marks)
FROM subjects;

-- (c) Find the subject with the highest max_marks.
SELECT MAX(max_marks)
FROM subjects;

-- (d)) Count how many subjects have max_marks = 100.
SELECT COUNT(*)
FROM subjects
WHERE max_marks=100;

-- (e) List each teacher name and count how many subjects they teach.
SELECT teacher_name, COUNT(*)
FROM subjects
GROUP BY teacher_name;

-- Q10(a)





