# frozen_string_literal: true

require './lib/database_connection'

feature 'viewing all properties' do
  scenario 'add a new property' do
    create_user
    sign_in
    visit('/')
    list_property

    expect(page).to have_content 'new property'
    expect(page).to have_content 'wow, so nice'
    expect(page).to have_content '123421'
  end

  scenario 'user cannot post new property when not signed in' do
    visit('/')

    expect(page).not_to have_selector("input[type=submit][value='New Property']")
  end
end
