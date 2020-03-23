feature 'registration' do
  scenario 'a user can sign up to our website' do
    visit '/sign-up'
    fill_in('name', with: 'John Doe')
    fill_in('email', with: 'test@test.com')
    fill_in('password', with: 'password123')
    click_button('Submit')
    
    expect(page).to have_content 'Welcome, John Doe'
  end
end
