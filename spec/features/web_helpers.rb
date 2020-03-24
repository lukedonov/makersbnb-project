def sign_up
  visit '/sign-up'
  fill_in('name', with: 'John Doe')
  fill_in('email', with: 'test@test.com')
  fill_in('password', with: 'test')
  click_button('Submit')
end

def sign_in
  visit '/sign-in'
  fill_in(:email, with: 'test@test.com')
  fill_in(:password, with: 'test')
  click_button('Sign In')
end

def create_user
  User.create(name: 'John Doe', email: 'test@test.com', password: 'test')
end

def list_property
  click_button('New Property')
  fill_in('name', with: 'new property')
  fill_in('description', with: 'wow, so nice')
  fill_in('cpn', with: '123421')
  click_button('Submit')
end