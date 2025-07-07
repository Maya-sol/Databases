CREATE SCHEMA IF NOT EXISTS study_tracker;

CREATE TABLE IF NOT EXISTS study_tracker.Students(
    Student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    university VARCHAR(50),
    Major VARCHAR(50) NOT NULL,
	year INT NOT NULL 
);

CREATE TABLE IF NOT EXISTS study_tracker.Courses (
    Course_id INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    teacher VARCHAR(50),
    Major VARCHAR(50) NOT NULL,
    YEAR INT NOT NULL
);

CREATE TABLE IF NOT EXISTS study_tracker.Sessions (
    Session_id INT PRIMARY KEY,
    Student_id INT REFERENCES study_tracker.Students(Student_id),
    Course_id INT REFERENCES study_tracker.Courses(Course_id),
    date DATE,
    topic VARCHAR(100)
);


CREATE TABLE IF NOT EXISTS study_tracker.Assignments (
    Assignment_id INT PRIMARY KEY,
    Course_id INT REFERENCES study_tracker.Courses(Course_id),
    deadline DATE,
    type VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS study_tracker.Ind_Assignment (
    Indas_id INT PRIMARY KEY,
    Assignment_id INT REFERENCES study_tracker.Assignments(Assignment_id),
    Student_id INT REFERENCES study_tracker.Students(Student_id),
    grade INT,
	CONSTRAINT g_range CHECK (grade IS NULL OR (grade BETWEEN 0 AND 100))
);
CREATE TABLE IF NOT EXISTS study_tracker.Goals (
    Goal_id INT PRIMARY KEY,
    Student_id INT REFERENCES study_tracker.Students(Student_id),
    description VARCHAR(150) NOT NULL
);