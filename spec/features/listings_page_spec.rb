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

  scenario 'add a new listing' do

    user = User.create(name: 'John Doe', email: 'john@doe.com', password: '123456789')

    #change to match sign-in page

    visit('/sign-in')
    fill_in('email', with: user.email)
    fill_in('password', with: '123456789')
    click_button('Sign In')

    #------

    visit('/listings')
    click_button('New Listing')
    fill_in('name', with: 'new property')
    fill_in('description', with: 'wow, so nice')
    fill_in('cpn', with: '123421')
    click_button('Submit')
    expect(page).to have_content "new property"
    expect(page).to have_content "wow, so nice"
    expect(page).to have_content "123421"
  end

  scenario "user cannot post new listing when not signed in" do
    visit('/listings')
    expect(page).not_to have_selector("input[type=submit][value='New Listing']")
  end
end
