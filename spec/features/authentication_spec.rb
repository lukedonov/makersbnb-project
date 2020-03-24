# frozen_string_literal: true

feature 'sign in/out' do

  before(:each) do
    create_user
  end

  it 'a user can sign in' do
    sign_in

    expect(page).to have_content 'Welcome, John Doe'
  end

  it 'a user cannot sign in with wrong email' do
    sign_in_with_wrong_email

    expect(page).not_to have_content 'Welcome, Bob'
  end

  it 'a user can sign out' do
    sign_in
    click_button('Sign out')

    expect(page).not_to have_content 'Welcome, John Doe'
    expect(page).to have_content 'You have signed out.'
  end  

  
end
