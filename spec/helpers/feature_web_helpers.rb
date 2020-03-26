# frozen_string_literal: true

require './spec/helpers/user_web_helper.rb'

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

def sign_up_and_in_other_test_user
  visit '/sign-up'
  fill_in('name', with: 'Bob')
  fill_in('email', with: 'bob@bob.com')
  fill_in('password', with: 'bob')
  click_button('Submit')
  visit '/sign-in'
  fill_in(:email, with: 'bob@bob.com')
  fill_in(:password, with: 'bob')
  click_button('Sign In')
end

def create_user
  User.create(name: 'John Doe', email: 'test@test.com', password: 'test')
end

def create_property
  Property.create(name: 'House John', description: 'a splendid house made of cheese', cpn: 134, user_id: 1)
end

def list_property
  click_button('New Property')
  fill_in('name', with: 'new property')
  fill_in('description', with: 'wow, so nice')
  fill_in('cpn', with: '123421')
  fill_in('start_date', with: '22 Jun 2020')
  fill_in('end_date', with: '23 Jun 2020' )
  click_button('Submit')
end