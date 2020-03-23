# frozen_string_literal: true

require './lib/database_connection'

def setup_test_database
  connection = DatabaseConnection.setup('inncognito_test')
  # Clear tables
  connection.query('TRUNCATE users, properties;')
end
