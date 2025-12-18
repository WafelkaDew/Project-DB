-- 1 
-- В изначальной таблице нарушалось правило 1НФ с атомарностью данных. В Имена участников проекта могли повторяться. Располовинил изначальную таблицу и создал
-- связующую, организовав связь many to many

CREATE TABLE project (
    project_id INT PRIMARY KEY,
    project_name VARCHAR (255)
);

CREATE TABLE members (
    member_id INT PRIMARY KEY,
    member_name VARCHAR (1000)
);

CREATE TABLE project_members (
    project_id INT,
    member_id INT,
    PRIMARY KEY (project_id, member_id),
    FOREIGN KEY (project_id) REFERENCES project (project_id),
    FOREIGN KEY (member_id) REFERENCES members (member_id)
);

-- 2
-- Изначальная таблица не соответсвовала НФ2 так, как присутствовала частичная зависимость.

CREATE TABLE equipment (
    equipment_id INT,
    equipment_name VARCHAR(255),
);

CREATE TABLE clients (
    client_id INT,
    client_name VARCHAR(255),
    client_email VARCHAR(255)
);
 
 CREATE TABLE rentals (
    client_id INT,
    equipment_id INT,
    rental_date DATE,
    PRIMARY KEY (client_id, equipment_id),
    FOREIGN KEY (client_id) REFERENCES clients(client_id),
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id)
 );

 -- 3
-- Нарушение НФ1 - уничтоженная атомарность информации
-- из-за попытки уместить всё в строку assignments_and_grades
-- Разделил таблицу

 CREATE TABLE student_courses(
    student_id INT,
    course_id INT,
    student_name VARCHAR(255),
    course_professor VARCHAR(255),
    PRIMARY KEY (student_id, course_id)
 );

 CREATE TABLE student_grade(
    student_id INT,
    course_id INT,
    assignment_name VARCHAR(255),
    grade INT,
    PRIMARY KEY (student_id, course_id, assignment_name),
    FOREIGN KEY (student_id, course_id) REFERENCES student_courses (student_id, course_id)
 );

-- Нарушение НФ2 - присутсвует частичная зависимость,
-- лучше оптимизировать данные, создав связи many to many

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(255)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_professor VARCHAR(255)
);

CREATE TABLE student_course(
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses (course_id)
);

CREATE TABLE students_grade(
    student_id INT,
    course_id INT,
    assignment_name VARCHAR(255),
    grade INT,
    PRIMARY KEY (student_id, course_id, assignment_name),
    FOREIGN KEY (student_id, course_id) REFERENCES student_course(student_id, course_id)
);