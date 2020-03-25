
class UserWebHelper
  
  USER_POOL = [
    { name: 'Bob', email: 'bob@bob.com', password: '12345' },
    { name: 'Eleanor', email: 'elle@gmail.com', password: 'sharksAreOlderThanTrees' }
  ]

  def self.setup
    @@users = USER_POOL
    @@users_with_index = USER_POOL
  end

  def self.get_user
    @@users.shift
  end
  
  def self.get_user_with_index(i)
    @@users_with_index[i]
  end

end