feature "editing a property's details" do

  scenario "a host can change a property's name, description and cost per night"  do
    sign_up
    sign_in
    list_property
    click_button('View Booking Requests')
    click_button('Edit')
    fill_in('name', with: 'changing name')
    fill_in('description', with: 'this is an edit')
    fill_in('cpn', with: '50')
    click_button('Submit')

    expect(page).to have_content 'changing name'

  end

end