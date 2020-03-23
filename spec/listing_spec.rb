# frozen_string_literal: true

require 'pg'
require './lib/database_connection'
require 'listing'

describe Listing do
  connection = DatabaseConnection.setup('inncognito_test')

  describe '.all' do
    it('returns a list of listings') do
      connection.query("INSERT INTO users (id, name, email, password) VALUES ('1', 'bob', 'bob@bob.bob', 'bobbobbob');")
      connection.query("INSERT INTO properties (name, cpn, description, user_id) VALUES('test property', 122, 'test test test', '1');")
      listings = Listing.all
      expect(listings.first.name).to eq('test property')
      expect(listings.first.description).to eq('test test test')
      expect(listings.first.cpn).to eq(122)
    end
  end
end
