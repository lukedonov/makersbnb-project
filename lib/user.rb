require_relative './database_connection'
class User
  attr_reader :name, :email, :password
  def initialize(name:, email:, password:)
    @name = name
    @email = email
    @password = password

  end

end