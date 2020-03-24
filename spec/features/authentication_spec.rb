# frozen_string_literal: true

feature 'sign in' do
  it 'a user can sign in' do
    User.create(name: 'Bob', email: 'bob@bob.com', password: 'bob')

    visit '/sign-in'
    fill_in(:email, with: 'bob@bob.com')
    fill_in(:password, with: 'bob')
    click_button('Sign In')

    expect(page).to have_content 'Welcome, Bob'
  end
  it 'a user cannot sign in with wrong email' do
    User.create(name: 'Bob', email: 'bob@bob.com', password: 'bob')

    visit '/sign-in'
    fill_in(:email, with: 'wrongemail@wrong.com')
    fill_in(:password, with: 'bob')
    click_button('Sign In')

    expect(page).not_to have_content 'Welcome, Bob'
  end
end
