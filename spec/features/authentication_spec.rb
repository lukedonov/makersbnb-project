feature 'sign in' do

  it 'a user can sign in' do
    User.create(name: 'Bob', email: 'bob@bob.com', password: 'bob')

    visit '/sessions/new'
    fill_in(:email, with: 'bob@bob.com')
    fill_in(:password, with: 'bob')
    click_button('Sign in')

    expect(page).to have_content 'Welcome, Bob'
  end

end