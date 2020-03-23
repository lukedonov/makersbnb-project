# frozen_string_literal: true

require 'pg'

# Query and connect to PostreSQL database
class DatabaseConnection
  def self.setup(dbname)
    @connection = PG.connect(dbname: dbname)
  end

  def self.query(sql)
    @connection.exec(sql)
  end

  def self.prepare(text)
    @connection.escape(text)
  end
end
