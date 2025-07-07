CREATE OR REPLACE FUNCTION study_tracker.student_avg_grade(student_id INT) 
RETURNS DECIMAL AS $$
DECLARE
    avg_grade DECIMAL;
BEGIN
    SELECT AVG(grade) INTO avg_grade
    FROM study_tracker.Ind_Assignment
    WHERE Ind_Assignment.student_id = student_avg_grade.student_id;
    RETURN COALESCE(avg_grade, 0);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION study_tracker.active_courses(student_id INT)
RETURNS INT AS $$
DECLARE
    course_count INT;
BEGIN
    SELECT COUNT(DISTINCT Course_id) INTO course_count
    FROM study_tracker.Sessions
    WHERE Sessions.Student_id = active_courses.student_id;
    
    RETURN course_count;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE study_tracker.update_major(student_id INT, new_major VARCHAR(50))
AS $$
BEGIN
    UPDATE study_tracker.students
    SET Major = new_major
    WHERE students.student_id = update_major.student_id;
    
    IF NOT FOUND THEN
        RAISE NOTICE ' ID % not found', student_id;
    END IF;
END;
$$ LANGUAGE plpgsql;
