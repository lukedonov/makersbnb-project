# frozen_string_literal: true

feature 'sign in' do
  before(:each) do
    create_user
  end

  it 'a user can sign in' do
    sign_in
    expect(page).to have_content 'Welcome, John Doe'
  end

  it 'a user cannot sign in with wrong email' do
    sign_in_with_wrong_email
    expect(page).not_to have_content 'Welcome, John Doe'
  end
end
