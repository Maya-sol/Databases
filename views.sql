CREATE OR REPLACE VIEW seniors AS
SELECT *
FROM study_tracker.students
WHERE year = 4
order by student_id;

CREATE OR REPLACE VIEW teachers AS
SELECT DISTINCT teacher
FROM study_tracker.courses
ORDER BY teacher