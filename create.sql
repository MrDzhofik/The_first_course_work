DROP TABLE IF EXISTS Discipline CASCADE;
DROP TABLE IF EXISTS Reprimand CASCADE;
DROP TABLE IF EXISTS Kudo CASCADE;
DROP TABLE IF EXISTS Mark CASCADE;
DROP TABLE IF EXISTS Student CASCADE;
DROP TABLE IF EXISTS Gruppa CASCADE;
DROP TABLE IF EXISTS Teacher CASCADE;
DROP TABLE IF EXISTS Department;

CREATE TABLE Department(
	department_id varchar PRIMARY KEY,
	department_name varchar,
	phone_number varchar,
	year_of_creation int,
	head_of_department varchar
);

CREATE TABLE Teacher(
	teacher_id varchar PRIMARY KEY,
	full_name varchar,
	phone_number varchar,
	department varchar,
	date_of_birth date,
	CONSTRAINT fk_department
		FOREIGN KEY(department) REFERENCES Department(department_id)
);

CREATE TABLE Gruppa (
	group_id varchar PRIMARY KEY,
	headman varchar,
	student_amount int,
	department varchar,
	mentor varchar,
	CONSTRAINT fk_mentor
	FOREIGN KEY (mentor) REFERENCES Teacher(teacher_id)
);

CREATE TABLE Discipline(
	discipline_id varchar PRIMARY KEY,
	discipline_name varchar,
	department varchar,
	CONSTRAINT fk_depart
	FOREIGN KEY (department) REFERENCES Department(department_id)
);

CREATE TABLE Student(
	student_id varchar PRIMARY KEY,
	full_name varchar,
	date_of_birth date,
	phone_number varchar,
	grupp varchar,
	passport_number varchar,
	arrears int,
	studying bool,
	course_of_study int,
	dormitory boolean,
	scholarship int, 
	year_of_enter int,
	year_of_end int,
	military_study boolean,
	CONSTRAINT fk_grupp
		FOREIGN KEY (grupp) REFERENCES Gruppa(group_id)
);

CREATE TABLE Reprimand(
	reprimand_id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	student varchar,
	topic varchar,
	sign varchar,
	give_date date,
	CONSTRAINT fk_student
	FOREIGN KEY(student) REFERENCES Student(student_id)
);

CREATE TABLE Kudo(
	kudo_id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	student varchar,
	topic varchar,
	give_date date,
	CONSTRAINT fk_studen
	FOREIGN KEY(student) REFERENCES Student(student_id)
);

CREATE TABLE Mark(
	mark_id varchar PRIMARY KEY,
	student varchar,
	teacher varchar,
	discipline varchar,
	mark_type varchar,
	mark int,
	mark_date date,
	CONSTRAINT fk_stud
	FOREIGN KEY(student) 
	REFERENCES Student(student_id),
	CONSTRAINT fk_teach
	FOREIGN KEY(teacher) 
	REFERENCES Teacher(teacher_id),
	CONSTRAINT fk_discipline
	FOREIGN KEY(discipline) 
	REFERENCES Discipline(discipline_id)
)
