# frozen_string_literal: true

require_relative './database_connection'

class User
  def self.create(name:, email:, password:)
    result = DatabaseConnection.query("INSERT INTO users (name, email, password) VALUES ('#{name}', '#{email}', '#{password}') RETURNING id, name, email;")
    User.new(
      id: result[0]['id'],
      name: result[0]['name'],
      email: result[0]['email']
    )
  end

  attr_reader :id, :name, :email
  def initialize(id:, name:, email:)
    @id = id
    @name = name
    @email = email
  end
end
