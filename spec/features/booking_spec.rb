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
    fill_in "start_date", with: "2020-07-26"
    fill_in "end_date", with: "2020-07-28"
    click_button("Request booking")
    expect(page).to have_content("Your request to book new property for 2 nights has been sent")
  end

  scenario "A host can receive a booking request" do
    sign_up
    sign_in
    list_property
    click_button "View Booking Requests"
    expect(page).to have_content("You currently have 0 booking requests")
  end

  scenario "A host can receive a booking request" do
    user = User.create(name: 'John Doe', email: 'test@test.com', password: 'test')
    property = Property.create(name: 'House John', description: 'a splendid house made of cheese', cpn: 134, user_id: user.id)
    availability = Availability.create(property_id: property.id, start_date: '2020-03-25 00:00:00', end_date: '2020-03-27 00:00:00')
    sign_up_and_in_other_test_user
    click_button('Book')
    fill_in "start_date", with: "2020-03-25 00:00:00"
    fill_in "end_date", with: "2020-03-27 00:00:00"
    click_button("Request booking")
    click_button("Back to properties")
    click_button('Sign out')
    sign_in
    click_button "View Booking Requests"
    expect(page).to have_content("You currently have 1 booking requests")
  end

  scenario "A host can see all their properties on their account page" do
    sign_up
    sign_in
    list_property
    click_button('New Property')
    fill_in('name', with: 'a second property')
    fill_in('description', with: 'even nicer')
    fill_in('cpn', with: '50')
    fill_in('start_date', with: '24 Jun 2020')
    fill_in('end_date', with: '25 Jun 2020')
    click_button('Submit')
    click_button("View Booking Requests")

    expect(page).to have_content("new property")
    expect(page).to have_content("a second property")
  end



end