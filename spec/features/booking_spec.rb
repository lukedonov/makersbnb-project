feature 'booking a property' do

  scenario 'a guest can view a property in the booking page' do
    sign_up
    sign_in
    list_property
    click_button('Sign out')
    sign_up_and_in_other_test_user
    click_button('Book')

    expect(page).not_to have_content 'Welcome, Bob'
    expect(page).to have_content 'new property'
    expect(page).to have_content 'wow, so nice'
    expect(page).to have_content '123421'
    expect(page).to have_button('Request booking')
  end

  scenario 'a guest can request to book a property' do
    sign_up
    sign_in
    list_property
    click_button('Sign out')
    sign_up_and_in_other_test_user
    click_button('Book')
    fill_in "start-date", with: "25/03/20"
    select "2 night", :from => "duration"
    click_button("Request booking")
    expect(page).to have_content("Your request to book new property for 2 nights has been sent")
  end



end