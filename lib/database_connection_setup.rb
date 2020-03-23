# frozen_string_literal: true

require './lib/database_connection'

if ENV['ENVIRONMENT'] == 'test'
  DatabaseConnection.setup('inncognito_test')
else
  DatabaseConnection.setup('inncognito')
end
