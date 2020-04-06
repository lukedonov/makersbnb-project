# frozen_string_literal: true

feature 'booking a property (host perspective)' do
  scenario 'A host has 0 booking requests by default' do
    sign_up
    sign_in
    list_property
    click_button 'View Booking Requests'
    expect(page).to have_content('You currently have 0 property requests')
  end

  scenario 'A host can receive a booking request' do
    user = User.create(name: 'John Doe', email: 'test@test.com', password: 'test')
    property = Property.create(name: 'House John', description: 'a splendid house made of cheese', cpn: 134, user_id: user.id)
    availability = Availability.create(property_id: property.id, start_date: '2020-03-25 00:00:00', end_date: '2020-03-27 00:00:00')
    sign_up_and_in_other_test_user
    click_button('Book')
    fill_in 'start_date', with: '2020-03-25 00:00:00'
    fill_in 'end_date', with: '2020-03-27 00:00:00'
    click_button('Request booking')
    click_button('Back to properties')
    click_button('Sign out')
    sign_in
    click_button 'View Booking Requests'
    expect(page).to have_content('You currently have 1 property request')
  end
end
