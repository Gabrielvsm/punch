require 'sqlite3'

module DataBase
  class << self
    def add_task(name, last_punch)
      return 'Task already exists' if exists?(name)

      query = <<~SQL
        INSERT INTO tasks (task_name, time_spent, last_punch, working)
        VALUES ("#{name}", 0.0, #{last_punch}, true);
      SQL

      execute_query(query)
    end

    #  Punches the new starting working time on a task when the user
    # resumes working on it
    def resumed_working(name, punch)
      return 'Task not found' unless exists?(name)

      query = <<~SQL
        UPDATE tasks
        SET last_punch=#{punch},
            working=true
        WHERE task_name="#{name}";
      SQL

      execute_query(query)
    end

    # Called when the user pauses the work on a task
    # Updates the time spent on it
    def paused_working(name, punch)
      return 'Task not found' unless exists?(name)

      time_spent = get_time_spent(name) + (punch - get_last_punch(name))

      query = <<~SQL
        UPDATE tasks
        SET last_punch=#{punch},
            time_spent=#{time_spent},
            working=false
        WHERE task_name="#{name}";
      SQL

      execute_query(query)
    end

    def working?(name)
      return 'Task not found' unless exists?(name)

      query = <<~SQL
        SELECT working FROM tasks
        WHERE task_name="#{name}";
      SQL

      execute_query(query)[0][0] == 1
    end

    def get_total_time_spent(name)
      return 'Task not found' unless exists?(name)

      query = <<~SQL
        SELECT time_spent FROM tasks
        WHERE task_name="#{name}";
      SQL
      execute_query(query)[0][0]
    end

    def delete_task(name)
      return 'Task not found' unless exists?(name)

      query = <<~SQL
        DELETE FROM tasks
        WHERE task_name="#{name}";
      SQL

      execute_query(query)
    end

    def list
      query = 'SELECT task_name, time_spent FROM tasks'

      execute_query(query)
    end

    private

    def get_time_spent(name)
      query = "SELECT time_spent FROM tasks WHERE tasks.task_name='#{name}'"
      execute_query(query)[0][0]
    end

    def get_last_punch(name)
      query = "SELECT last_punch FROM tasks WHERE tasks.task_name='#{name}'"
      execute_query(query)[0][0]
    end

    def exists?(name)
      query = <<~SQL
        SELECT * FROM tasks
        WHERE tasks.task_name="#{name}";
      SQL

      !execute_query(query).empty?
    end

    #  All operations on the database are done here to handle exception and centralize
    # access in one place
    def execute_query(query)
      result = []

      begin
        db = SQLite3::Database.open 'share/database.db'
        result = db.execute(query)
      rescue SQLite3::Exception => e
        puts e
      ensure
        db.close if db
      end

      result
    end
  end
end
