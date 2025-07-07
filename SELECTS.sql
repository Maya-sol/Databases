SELECT * 
FROM study_tracker.goals;

SELECT * 
FROM study_tracker.students
WHERE year = 1
ORDER BY name;

SELECT * 
FROM study_tracker.courses
WHERE year = 1 AND major = 'applied math';

SELECT indas_id, assignment_id 
FROM study_tracker.ind_assignment
WHERE grade is NULL;

SELECT assignment_id, student_id, grade
FROM study_tracker.ind_assignment
WHERE grade is NOT NULL AND grade < 70
ORDER BY grade;

SELECT major, year
FROM study_tracker.students
GROUP BY major, year
ORDER BY year;

SELECT study_tracker.courses.major, study_tracker.courses.teacher, 
                    study_tracker.assignments.type AS assignment_title
FROM study_tracker.courses
JOIN study_tracker.assignments
ON study_tracker.assignments.course_id = study_tracker.courses.course_id;

SELECT topic
FROM study_tracker.sessions
GROUP BY topic
ORDER BY topic DESC;

SELECT  study_tracker.ind_assignment.grade, study_tracker.students.name
FROM study_tracker.ind_assignment
JOIN study_tracker.students
ON study_tracker.students.student_id = study_tracker.ind_assignment.student_id
WHERE grade IS NOT NULL
ORDER BY grade DESC;

SELECT study_tracker.assignments.type, avg(study_tracker.ind_assignment.grade)
FROM study_tracker.assignments
JOIN study_tracker.ind_assignment
ON study_tracker.assignments.assignment_id = study_tracker.ind_assignment.assignment_id
WHERE study_tracker.ind_assignment.grade IS NOT NULL 
GROUP BY study_tracker.assignments.type;