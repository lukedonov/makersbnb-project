# frozen_string_literal: true

feature 'authentication' do
  before(:each) do
    create_user
  end

  it 'a user can sign in' do
    sign_in

    expect(page).to have_content 'Logged in as John Doe'
  end

  it 'a user cannot sign in with wrong email' do
    visit '/sign-in'
    fill_in(:email, with: 'test_wrong@test.com')
    fill_in(:password, with: 'test')
    click_button('Sign In')

    expect(page).not_to have_content 'Welcome, John Doe'
  end

  it 'a user cannot sign in with wrong password' do
    visit '/sign-in'
    fill_in(:email, with: 'test@test.com')
    fill_in(:password, with: 'wrong')
    click_button('Sign In')

    expect(page).not_to have_content 'Welcome, John Doe'
  end

  it 'a user can sign out' do
    sign_in
    click_button('Sign out')

    expect(page).not_to have_content 'Welcome, John Doe'
    expect(page).to have_content 'You have signed out.'
  end
end
