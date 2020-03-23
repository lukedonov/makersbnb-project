# frozen_string_literal: true

require './lib/database_connection'

feature 'viewing all listings' do
  scenario 'viewing the listings page' do
    visit('/listings')
    expect(page).to have_content 'Welcome to Inn Cognito'
  end

  scenario 'viewing the listings' do
    visit('/listings')
    # connection = DatabaseConnection.setup('inncognito_test')
    # connection.query("INSERT INTO users (id, name, email, password) VALUES ('1', 'bob', 'bob@bob.bob', 'bobbobbob');")
    # connection.query("INSERT INTO properties (name, cpn, description, user_id) VALUES('test property', 122, 'test test test', '1');")
    # expect(page).to have_content 'test property'
    # expect(page).to have_content '122'
    # expect(page).to have_content 'test test test'
  end
end
