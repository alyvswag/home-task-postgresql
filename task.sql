create table student_management.students
(
    id         serial primary key,
    name       varchar(20)             not null,
    surname    varchar(20)             not null,
    email      text unique             not null,
    is_active  boolean   default true  not null,
    created_at TIMESTAMP default now() not null,
    updated_at TIMESTAMP
);
create table student_management.subject
(
    id           serial primary key,
    subject_name text                    not null,
    is_active    boolean   default true  not null,
    created_at   TIMESTAMP default now() not null,
    updated_at   TIMESTAMP
);
create table student_management.grades
(
    id          serial primary key,
    student_id  integer                 not null,
    subject_id  integer                 not null,
    grade       VARCHAR(1)              not null CHECK (grade IN ('A', 'B', 'C', 'D', 'E', 'F')),
    grade_score decimal(3, 1)           not null,
    is_active   boolean   default true  not null,
    created_at  TIMESTAMP default now() not null,
    updated_at  TIMESTAMP,
--  foreign key
    CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES student_management.students (id),
    CONSTRAINT fk_subject FOREIGN KEY (subject_id) REFERENCES student_management.subject (id)
);

INSERT into student_management.students(name, surname, email)
values ('Talib', 'Aliyev', 'example1@gmail.com'),
       ('Ilkin', 'Quliyev', 'example2@gmail.com'),
       ('Turqan', 'Ibrahimzade', 'example3@gmail.com'),
       ('Osman', 'Nezerli', 'example4@gmail.com');

INSERT into student_management.subject(subject_name)
values ('İnformasiya təhlükəsizliyinin idarəedilməsi sistemləri'),
       ('Verilənlər bazalarının təhlükəsizliyi'),
       ('Bulud təhlükəsizliyi'),
       ('Kriptoqrafiyanın əsasları');

UPDATE student_management.students s
SET is_active  = false,
    updated_at = now()
WHERE s.id = 3
  and is_active = true;


SELECT s.name,
       s.surname,
       sub.subject_name,
       g.grade,
       g.grade_score
FROM student_management.grades g
         JOIN
     student_management.students s ON g.student_id = s.id
         JOIN
     student_management.subject sub ON g.subject_id = sub.id
WHERE g.student_id = 2
  and s.is_active = true;

SELECT s.name,
       s.surname,
       sub.subject_name,
       g.grade,
       g.grade_score
FROM student_management.grades g
         JOIN
     student_management.students s ON g.student_id = s.id
         JOIN
     student_management.subject sub ON g.subject_id = sub.id
WHERE g.subject_id = 2
  and s.is_active = true;
SELECT s.name, s.surname, sub.subject_name, g.grade, g.grade_score
FROM student_management.grades g
          JOIN student_management.students s ON g.student_id = s.id
          JOIN student_management.subject sub ON g.subject_id = sub.id;



alter table student_management.grades
    alter column grade_score type numeric(3) using grade_score::numeric(3);

