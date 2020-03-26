# frozen_string_literal: true

require 'pg'
require './lib/database_connection'
require_relative '../helpers/database_helpers.rb'
require 'Property'
require 'user'

describe Property do
  PG.connect(dbname: 'inncognito_test')

  describe '.all' do
    it('returns a list of properties') do
      create_user_and_property
      properties = Property.all

      expect(properties.first.name).to eq('House John')
      expect(properties.first.description).to eq('a splendid house made of cheese')
      expect(properties.first.cpn).to eq(134)
    end
  end

  describe '.create' do
    it('creates then returns a new Property instance') do
      create_user_and_property

      expect(@property.name).to eq('House John')
      expect(@property.description).to eq('a splendid house made of cheese')
      expect(@property.cpn).to eq(134)
      expect(@property.user_id).to eq(@user.id)
    end
  end

  describe '.where' do
    it 'gets the relevant id number from the user database' do
      create_user_and_property

      persisted_data(table: 'properties', id: @property.id)
      expect(@property.user_id).to eq @user.id
    end
  end

  describe '.sort_by_recent' do
    it('displays the results by most recent entry first') do
      create_user_and_property
      create_second_property

      expect(@sorted_property.first.name).to eq @property2.name
    end
  end

  describe '.find' do
    it 'find a property by ID' do
      create_user_and_property
      result = Property.find(id: @property.id)

      expect(result.id).to eq @property.id
      expect(result.description).to eq 'a splendid house made of cheese'
      expect(result.cpn).to eq 134
    end
  end
end
