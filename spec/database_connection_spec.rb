# frozen_string_literal: true

require 'database_connection'

describe DatabaseConnection do
  describe '.setup' do
    it 'sets up a connection to a database through PG' do
      expect(PG).to receive(:connect).with(dbname: 'inncognito_test')
      DatabaseConnection.setup('inncognito_test')
    end
  end

  describe '.query' do
    it 'executes a query via PG' do
      connection = DatabaseConnection.setup('inncognito_test')

      expect(connection).to receive(:exec).with('SELECT * FROM properties;')

      DatabaseConnection.query('SELECT * FROM properties;')
    end
  end
end
