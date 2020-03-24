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

  describe '.create' do
    it('adds a listing to the database') do
      connection.query("INSERT INTO users (id, name, email, password) VALUES ('1', 'bob', 'bob@bob.bob', 'bobbobbob');")
      listing = Listing.create(name: "test property", description: "a splendid house made of cheese", cpn: '134', user_id: '1')
      expect(listing.name).to eq "test property"
      expect(listing.description).to eq "a splendid house made of cheese"
      expect(listing.cpn).to eq 134
      expect(listing.user_id).to eq '1'
    end
  end

  describe '.sort_by_recent' do
    it('displays the results by most recent entry first') do
      connection.query("INSERT INTO users (id, name, email, password) VALUES ('1', 'bob', 'bob@bob.bob', 'bobbobbob');")
      Listing.create(name: "test property", description: "a splendid house made of cheese", cpn: '134', user_id: '1')
      property = Listing.create(name: "test property2", description: "a splendid house made of eggs", cpn: '133', user_id: '1')
      listing = Listing.sort_by_recent
      
      expect(listing.first.name).to eq property.name;

    end
  end

end
