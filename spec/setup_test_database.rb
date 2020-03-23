# frozen_string_literal: true

require 'pg'

def setup_test_database
  connection = PG.connect(dbname: 'inncognito_test')
  connection.exec('TRUNCATE users, properties;')
end
