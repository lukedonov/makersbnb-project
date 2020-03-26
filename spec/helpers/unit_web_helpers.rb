# frozen_string_literal: true

def create_user_and_property
  @current_user = User.create(name: 'John Doe', email: 'test@test.com', password: 'test')
  property = Property.create(name: 'House John', description: 'a splendid house made of cheese', cpn: 134, user_id: @current_user.id)
  properties = Property.where(user_id: @current_user.id)
  @property = properties.first
end

def create_second_property
  @property2 = Property.create(name: 'test property2', description: 'a splendid house made of eggs', cpn: 133, user_id: @current_user.id)
  @sorted_property = Property.sort_by_recent
end
