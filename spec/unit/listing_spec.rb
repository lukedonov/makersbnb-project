# frozen_string_literal: true

require 'pg'
require './lib/database_connection'
require_relative '../database_helpers.rb'
require 'Property'
require 'user'

describe Property do
  connection = DatabaseConnection.setup('inncognito_test')

  describe '.all' do
    it('returns a list of properties') do
      connection.query("INSERT INTO users (id, name, email, password) VALUES ('1', 'bob', 'bob@bob.bob', 'bobbobbob');")
      connection.query("INSERT INTO properties (name, cpn, description, user_id) VALUES('test property', 122, 'test test test', '1');")
      properties = Property.all
      expect(properties.first.name).to eq('test property')
      expect(properties.first.description).to eq('test test test')
      expect(properties.first.cpn).to eq(122)
    end
  end

  describe '.create' do
    it('creates then returns a new Property instance') do
      user = User.create(name: 'Bob', email: 'bob@bob.com', password: 'password')
      property = Property.create(name: 'Bobs House', description: 'bobby bob bob', cpn: 111, user_id: user.id)
      expect(property.name).to eq('Bobs House')
      expect(property.description).to eq('bobby bob bob')
      expect(property.cpn).to eq(111)
      expect(property.user_id).to eq(user.id)
    end
  end

  describe '.where' do
    it 'gets the relevant id number from the user database' do
      user = User.create(name: 'John Doe', email: 'john@doe.com', password: '123456789')
      Property.create(name: 'Bobs House', description: 'bobby bob bob', cpn: 111, user_id: user.id)

      properties = Property.where(user_id: user.id)
      property = properties.first
      persisted_data(table: 'properties', id: property.id)
      expect(property.user_id).to eq user.id
    end
  end

  describe '.sort_by_recent' do
    it('displays the results by most recent entry first') do
      connection.query("INSERT INTO users (id, name, email, password) VALUES ('1', 'bob', 'bob@bob.bob', 'bobbobbob');")
      Property.create(name: "test property", description: "a splendid house made of cheese", cpn: 134, user_id: '1')
      property = Property.create(name: "test property2", description: "a splendid house made of eggs", cpn: 133, user_id: '1')
      sorted_property = Property.sort_by_recent
      
      expect(sorted_property.first.name).to eq property.name;

    end
  end

end
