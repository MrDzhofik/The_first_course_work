class ShowController < ApplicationController
  require 'pg'
  DB = PG.connect(dbname: 'kursach', password: '246858')
  def department
    @department = (DB.exec "SELECT * FROM department LIMIT 50")
  end

  def group
    @group = (DB.exec "SELECT * FROM gruppa LIMIT 50")
  end

  def discipline
    @discipline = (DB.exec "SELECT * FROM discipline LIMIT 50")
  end

  def teacher
    @teachers = (DB.exec "SELECT * FROM teacher LIMIT 50")
  end

  def student
    @student = (DB.exec "SELECT * FROM student ORDER BY passport_number LIMIT 40")
  end

  def mark
    @mark = (DB.exec "SELECT * FROM mark LIMIT 50")
  end

  def kudo
    @kudo = (DB.exec "SELECT * FROM kudo WHERE give_date < '2023-06-01' LIMIT 50 ")
  end

  def reprimand
    @reprimand = (DB.exec "SELECT * FROM reprimand WHERE give_date < '2023-06-01' LIMIT 50")
  end

  def choice
  end

  def n1
    @request = (DB.exec "SELECT t.full_name, COUNT(r.reprimand_id) AS reprimand_count
    FROM gruppa g
    JOIN Student s ON s.grupp = g.group_id
    JOIN Reprimand r ON r.student = s.student_id
    JOIN Teacher t ON t.teacher_id = g.mentor
    GROUP BY t.full_name
    ORDER BY reprimand_count DESC
    LIMIT 1;")
  end

  def n2
    @request = (DB.exec "SELECT d.department_name, d.department_id, COUNT(m.mark) AS bad_mark
    FROM department d
    JOIN discipline di ON d.department_id = di.department
    JOIN mark m ON di.discipline_id = m.discipline
    WHERE m.mark = 5
    GROUP BY d.department_name, d.department_id
    ORDER BY bad_mark DESC
    LIMIT 5;")
  end

  def n3
    @request = (DB.exec "SELECT d.department_id, d.department_name, COUNT(g.group_id) as group_count
    FROM department d
    JOIN teacher t ON d.department_id = t.department
    JOIN gruppa g ON t.teacher_id = g.mentor
    GROUP BY department_id, department_name
    ORDER BY group_count DESC")
  end

  def n4
    @request = (DB.exec "SELECT g.group_id
      FROM gruppa g
      WHERE g.headman IN
      (SELECT s.full_name
      FROM student s
      WHERE
       (SELECT AVG(m.mark)
        FROM mark m
        WHERE m.student = s.student_id) >= 4.5)
      ")
  end

  def input5
  end

  def n5
    @code = params[:code]
    @request = (DB.exec "CREATE OR REPLACE FUNCTION calculate_average_mark(discipline_code varchar) RETURNS NUMERIC AS
    $$
    DECLARE
        avg_mark NUMERIC;
    BEGIN
        SELECT AVG(m.mark) INTO avg_mark
        FROM discipline d
        JOIN mark m ON d.discipline_id = m.discipline
        WHERE d.discipline_id = discipline_code;
    
        RETURN avg_mark;
    END;
    $$
    LANGUAGE plpgsql;
    
    SELECT round(calculate_average_mark('#{@code}'),2)")
  end

  def input6
  end

  def n6
    @code = params[:code]
    @request = (DB.exec "CREATE OR REPLACE FUNCTION calculate_average_student(student_code varchar) RETURNS NUMERIC AS
    $$
    DECLARE
        avg_mark NUMERIC;
    BEGIN
        SELECT AVG(m.mark) INTO avg_mark
        FROM student s
        JOIN mark m ON s.student_id = m.student
        WHERE s.student_id = student_code;
    
        RETURN avg_mark;
    END;
    $$
    LANGUAGE plpgsql;
    
    SELECT round(calculate_average_student('#{@code}'), 2)")
  end

  def input7
  end

  def n7
    @code = params[:code]
    @request = (DB.exec "CREATE OR REPLACE FUNCTION calculate_kudos_count(group_code varchar) RETURNS INT AS
    $$
    DECLARE
      kudos_count INT;
    BEGIN
      SELECT COUNT(*) INTO kudos_count
      FROM gruppa g
      JOIN student s ON g.group_id = s.grupp
      JOIN kudo k ON s.student_id = k.student
      WHERE g.group_id = group_code;
    
      RETURN kudos_count;
    END;
    $$
    LANGUAGE plpgsql;
    
    SELECT calculate_kudos_count('#{@code}')
    ")
  end
end
