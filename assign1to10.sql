
-- Task 1: create tables with primary key
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    duration INT
);

CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    age INT,
    course_id INT
);



-- Task 2: add foreign key constraint
ALTER TABLE students
ADD CONSTRAINT fk_course
FOREIGN KEY (course_id)
REFERENCES courses(course_id);



-- Task 3: add unique constraint to one column
ALTER TABLE students
ADD CONSTRAINT unique_email UNIQUE (email);



-- Task 4: add index on a column
CREATE INDEX idx_student_name ON students(name);



-- Task 5: insert some rows
INSERT INTO courses (course_name, duration) VALUES
('Database Systems', 40),
('Web Development', 50),
('Data Science', 60),
('Cloud Computing', 45);

INSERT INTO students (name, email, age, course_id) VALUES
('Alice', 'alice@example.com', 21, 1),
('Bob', 'bob@example.com', 23, 2),
('Charlie', 'charlie@example.com', 22, 3),
('David', 'david@example.com', 20, 1),
('Eva', 'eva@example.com', 24, 4);



-- Task 6: select using where, not in, like and order by
SELECT *
FROM students
WHERE age > 20
AND name NOT IN ('Bob', 'David')
AND email LIKE '%example%'
ORDER BY age DESC;



-- Task 7: select with group by, having, count, sum
SELECT c.course_name, COUNT(s.student_id) AS total_students
FROM courses c
JOIN students s ON c.course_id = s.course_id
GROUP BY c.course_name
HAVING COUNT(s.student_id) > 1;



-- Task 8: inner join
SELECT s.name, s.email, c.course_name
FROM students s
INNER JOIN courses c ON s.course_id = c.course_id;



-- Task 9: left join
SELECT s.name, s.email, c.course_name
FROM students s
LEFT JOIN courses c ON s.course_id = c.course_id;



-- Task 10: insert and update with commit and rollback
BEGIN;

INSERT INTO students (name, email, age, course_id)
VALUES ('Frank', 'frank@example.com', 25, 2);

UPDATE students
SET age = 26
WHERE name = 'Frank';

SAVEPOINT sp1;

INSERT INTO students (name, email, age, course_id)
VALUES ('Grace', 'grace@example.com', 22, 3);

-- rollback this insert
ROLLBACK TO sp1;

-- another valid insert
INSERT INTO students (name, email, age, course_id)
VALUES ('Helen', 'helen@example.com', 21, 1);

COMMIT;


-- at end (to view result)
SELECT * FROM students;
