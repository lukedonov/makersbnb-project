# frozen_string_literal: true

require './lib/database_connection'

feature 'viewing all properties' do
  scenario 'viewing the properties page' do
    visit('/properties')
    expect(page).to have_content 'Welcome to Inn Cognito'
  end

  scenario 'viewing the properties' do
    visit('/properties')
    # connection = DatabaseConnection.setup('inncognito_test')
    # connection.query("INSERT INTO users (id, name, email, password) VALUES ('1', 'bob', 'bob@bob.bob', 'bobbobbob');")
    # connection.query("INSERT INTO properties (name, cpn, description, user_id) VALUES('test property', 122, 'test test test', '1');")
    # expect(page).to have_content 'test property'
    # expect(page).to have_content '122'
    # expect(page).to have_content 'test test test'
  end

  scenario 'add a new property' do

    user = User.create(name: 'John Doe', email: 'john@doe.com', password: '123456789')

    #change to match sign-in page

    visit('/sign-in')
    fill_in('email', with: user.email)
    fill_in('password', with: '123456789')
    click_button('Sign In')

    #------

    visit('/properties')
    click_button('New Property')
    fill_in('name', with: 'new property')
    fill_in('description', with: 'wow, so nice')
    fill_in('cpn', with: '123421')
    click_button('Submit')
    expect(page).to have_content "new property"
    expect(page).to have_content "wow, so nice"
    expect(page).to have_content "123421"
  end

  scenario "user cannot post new property when not signed in" do
    visit('/properties')
    expect(page).not_to have_selector("input[type=submit][value='New Property']")
  end
end
