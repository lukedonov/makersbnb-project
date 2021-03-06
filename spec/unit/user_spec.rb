# frozen_string_literal: true

require_relative '../helpers/database_helpers.rb'

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

  describe '.authenticate' do
    it 'returns a user given a correct username and password, if one exists' do
      user = described_class.create(name: 'John Doe', email: 'john@doe.com', password: '123456789')
      authenticated_user = User.authenticate(email: 'john@doe.com', password: '123456789')

      expect(authenticated_user.id).to eq user.id
    end

    it 'returns nil given an incorrect email address' do
      User.create(name: 'John', email: 'john@doe.com', password: '123456789')

      expect(User.authenticate(email: 'nottherightemail@me.com', password: '123456789')).to be_nil
    end

    it 'returns nil given an incorrect email address' do
      User.create(name: 'John', email: 'john@doe.com', password: '123456789')

      expect(User.authenticate(email: 'john@doe.com', password: 'not_the_right_password')).to be_nil
    end

    it 'hashes the password using BCrypt' do
      expect(BCrypt::Password).to receive(:create).with('123456789')

      User.create(name: 'John Doe', email: 'john@doe.com', password: '123456789')
    end
  end
end
