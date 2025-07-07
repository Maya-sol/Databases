CREATE OR REPLACE FUNCTION study_tracker.check_major() 
RETURNS TRIGGER AS $$
DECLARE
    student_major VARCHAR(50);
    course_major VARCHAR(50);
BEGIN
    SELECT Major INTO student_major
    FROM study_tracker.students
    WHERE student_id = NEW.student_id;

    SELECT Major INTO course_major
    FROM study_tracker.courses
    WHERE course_id = NEW.course_id;

    IF student_major <> course_major THEN
        RAISE EXCEPTION 'Student major does not match course major';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER major_match
BEFORE INSERT OR UPDATE ON study_tracker.Sessions
FOR EACH ROW
EXECUTE FUNCTION study_tracker.check_major();



CREATE OR REPLACE TRIGGER validate_year
BEFORE INSERT OR UPDATE ON study_tracker.Students
FOR EACH ROW
EXECUTE FUNCTION study_tracker.validate_year();



CREATE OR REPLACE FUNCTION study_tracker.no_weekend_sessions() 
RETURNS TRIGGER AS $$
BEGIN
    IF EXTRACT(DOW FROM NEW.date) IN (0, 6) THEN
        RAISE EXCEPTION 'Sessions cannot be on weekends';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER no_weekend_sessions
BEFORE INSERT OR UPDATE ON study_tracker.Sessions
FOR EACH ROW
EXECUTE FUNCTION study_tracker.no_weekend_sessions();



CREATE OR REPLACE FUNCTION study_tracker.positive_grade() 
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.grade IS NOT NULL AND NEW.grade < 0 THEN
        RAISE EXCEPTION 'Grade must be a positive integer';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER positive_grade
BEFORE INSERT OR UPDATE ON study_tracker.Ind_Assignment
FOR EACH ROW
EXECUTE FUNCTION study_tracker.positive_grade();