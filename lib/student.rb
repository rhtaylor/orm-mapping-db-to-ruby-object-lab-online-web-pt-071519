class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
    # create a new Student object given a row from the database
    student = self.new

    student.id = row[0]
    student.name = row[1]
    student.grade = row[2]
    student
  end

  def self.all
    # retrieve all the rows from the "Students" database
    # remember each row should be a new instance of the Student class
    sql = <<-YOO
      SELECT * FROM students
             YOO
    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end
  end

  def self.find_by_name(name)
    # find the student in the database given a name
    # return a new instance of the Student class
    sqling = <<-SQL
    SELECT * FROM students WHERE name = ? LIMIT 1
                SQL
    DB[:conn].execute(sqling, name).map do |row|
      self.new_from_db(row)
    end.first

end
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
  def self.all_students_in_grade_9
      sql = <<-NICE
      SELECT * FROM students WHERE grade = 9
              NICE
      DB[:conn].execute(sql)
      end
  def self.students_below_12th_grade
    sql = <<-CANDIS
    SELECT * FROM students WHERE grade < 12
             CANDIS
    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end
 end

 def self.first_X_students_in_grade_10(x)
    sql = <<-SQLL
        SELECT * FROM students WHERE grade = 10 LIMIT ?
            SQLL
      DB[:conn].execute(sql, x).map do |row|

        self.new_from_db(row)
      end
 end

  self.first_student_in_grade_10
      sql = <<-LOVE
      SELECT * FROM students LIMIT 1
              LOVE
      DB[:conn].execute(sql)
  end
end
