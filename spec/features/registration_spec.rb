# frozen_string_literal: true

feature 'registration' do
  scenario 'a user can sign up to our website' do
    sign_up

    expect(page).to have_content 'Welcome'
  end
end
