# frozen_string_literal: true

require_relative './database_connection'

class Listing
  def self.all
    results = DatabaseConnection.query('SELECT * FROM properties')
    results.map { |property| property['name'] + ' - ' + property['cpn'] + '. ' + property['description'] }
  end
end
