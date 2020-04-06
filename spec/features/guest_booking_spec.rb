# frozen_string_literal: true

feature 'booking a property (guest perspective)' do
  scenario 'A guest has 0 pending booking requests by default' do
    sign_up
    sign_in
    click_button 'View Booking Requests'

    expect(page).to have_content('You currently have 0 pending booking requests')
  end

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
    fill_in 'start_date', with: '2020-07-26'
    fill_in 'end_date', with: '2020-07-28'
    click_button('Request booking')

    expect(page).to have_content('Your request to book new property for 2 nights has been sent')
  end

  scenario 'a guest can see how many pending booking requests they have' do
    sign_up
    sign_in
    list_property
    click_button('Sign out')
    sign_up_and_in_other_test_user
    click_button('Book')
    fill_in 'start_date', with: '2020-07-26'
    fill_in 'end_date', with: '2020-07-28'
    click_button('Request booking')
    click_button('Back to properties')
    click_button('View Booking Requests')

    expect(page).to have_content('You currently have 1 pending booking request')
  end

  scenario 'a guest can see the property they booked once the host has approved' do
    sign_up
    sign_in
    list_property
    click_button('Sign out')
    sign_up_and_in_other_test_user
    click_button('Book')
    fill_in 'start_date', with: '2020-07-26'
    fill_in 'end_date', with: '2020-07-28'
    click_button('Request booking')
    click_button('Back to properties')
    click_button('Sign out')
    sign_in
    click_button('View Booking Requests')
    click_button('Approve')
    click_button('Sign out')
    sign_in_other_test_user
    click_button('View Booking Requests')

    expect(page).to have_content('new property')
    expect(page).to have_content('Check in: 26 Jul 2020')
    expect(page).to have_content('Check out: 28 Jul 2020')
  end
end
