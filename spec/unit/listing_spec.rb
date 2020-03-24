# frozen_string_literal: true

require 'pg'
require './lib/database_connection'
require_relative '../database_helpers.rb'
require 'listing'
require 'user'

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

  describe '.create' do
    it('creates then returns a new Listing instance') do
      user = User.create(name: 'Bob', email: 'bob@bob.com', password: 'password')
      listing = Listing.create(name: 'Bobs House', description: 'bobby bob bob', cpn: 111, user_id: user.id)
      expect(listing.name).to eq('Bobs House')
      expect(listing.description).to eq('bobby bob bob')
      expect(listing.cpn).to eq(111)
      expect(listing.user_id).to eq(user.id)
    end
  end

  describe '.where' do
    it 'gets the relevant id number from the user database' do
      user = User.create(name: 'John Doe', email: 'john@doe.com', password: '123456789')
      listing = Listing.create(name: 'Bobs House', description: 'bobby bob bob', cpn: 111, user_id: user.id)

      properties = Listing.where(user_id: user.id)
      property = properties.first
      persisted_data(table: 'properties', id: property.id)
  
      sleep 20
      expect(property.user_id).to eq user.id
    end
  end
  
end
