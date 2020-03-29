# frozen_string_literal: true

feature "editing a property's details" do
  scenario "a host can change a property's name, description and cost per night and availability" do
    sign_up
    sign_in
    list_property
    click_button('View Booking Requests')
    click_button('Edit')
    fill_in('name', with: 'changing name')
    fill_in('description', with: 'this is an edit')
    fill_in('cpn', with: '50')
    fill_in('start_date', with: '01 Jul 2020')
    fill_in('end_date', with: '04 Jul 2020')
    click_button('Submit')
    visit('/')
    click_button('View Booking Requests')
    click_button('Edit')

    expect(page).to have_content 'changing name'
    expect(page).to have_content '04 Jul 2020'
  end
end
