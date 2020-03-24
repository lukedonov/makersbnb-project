# frozen_string_literal: true

require_relative '../database_helpers.rb'

require 'user'
describe User do
  describe '.create' do
    it 'creates a new user' do
      user = described_class.create(name: 'John Doe', email: 'john@doe.com', password: '123456789')
      persisted_data = persisted_data(table: :users, id: user.id)

      expect(user).to be_a(User)
      expect(user.id).to eq persisted_data.first['id']
      expect(user.name).to eq('John Doe')
      expect(user.email).to eq('john@doe.com')
    end
  end

  describe '.find' do
    it 'returns nil if there is no ID given' do
      expect(User.find(id: nil)).to eq nil
    end

    it 'find a user by ID' do
      user = described_class.create(name: 'John Doe', email: 'john@doe.com', password: '123456789')
      result = User.find(id: user.id)

      expect(result.id).to eq user.id
      expect(result.email).to eq user.email
    end
  end

  describe '.find_by_email' do
    it 'returns nil if there is no email given' do
      expect(User.find_by_email(email: nil)).to eq nil
    end

    it 'find a user by email' do
      user = described_class.create(name: 'John Doe', email: 'john@doe.com', password: '123456789')
      result = User.find_by_email(email: 'john@doe.com')

      expect(result.id).to eq user.id
      expect(result.email).to eq user.email
    end
  end
end
