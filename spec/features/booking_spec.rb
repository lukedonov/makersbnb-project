feature 'booking a property' do

  scenario 'a guest can view and request a property' do
    sign_up
    sign_in
    list_property
    click_button('Sign out')
    sign_up_and_in_other_test_user
    click_button('Book')

    expect(page).not_to have_content 'Welcome, Bob'
    expect(page).to have_button('Request booking')
  end

end