require 'user'
describe User do
  it 'can be created name, email and password' do
    user = described_class.new(name: 'John Doe', email: 'john@doe.com', password: '123456789')
    expect(user).to be_a(User)
    expect(user.name).to eq('John Doe')
    expect(user.email).to eq('john@doe.com')
    expect(user.password).to eq('123456789')
  end
end