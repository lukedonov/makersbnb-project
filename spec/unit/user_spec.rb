require 'user'
describe User do
  
  describe '.create' do
    it 'creates a new user' do
      user = described_class.create(name: 'John Doe', email: 'john@doe.com', password: '123456789')
      user_table = DatabaseConnection.query("SELECT * FROM users WHERE id = #{user.id};")

        expect(user).to be_a(User)
        expect(user.id).to eq user_table.first['id']
        expect(user.name).to eq('John Doe')
        expect(user.email).to eq('john@doe.com')
    end
  end

end