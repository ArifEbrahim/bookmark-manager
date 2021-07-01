require './lib/user.rb'
require 'database_helpers'

RSpec.describe User do
  describe '.create' do
    it 'creates a new user' do
      user = User.create(email: 'test@example.com', password: 'password123')
      persisted_data = persisted_data(table: 'users', id: user.id)


      expect(user).to be_a(User)
      expect(user.id).to eq(persisted_data['id'])
      expect(user.email).to eq('test@example.com')
    end
  end

  describe '.find' do
    it 'finds a user by ID' do
      user = User.create(email: 'test@example.com', password: 'password123')
      result = User.find(user.id)


      expect(result.id).to eq(user.id)
      expect(result.email).to eq('test@example.com')
    end

    it 'returns nil if there is no ID given' do
      expect(User.find(nil)).to eq(nil)
    end
  end

  describe '.authenticate' do
    it 'returns a user if one exsits' do
      user = User.create(email: 'test@example.com', password: 'password123')
      authenticated_user = User.authenticate(email: 'test@example.com', password: 'password123')
  
      expect(authenticated_user.id).to eq user.id
    end

    it 'returns nil when email incorrect' do
      user = User.create(email: 'test@example.com', password: 'password123')

      expect(User.authenticate(email: 'nottherightemail@me.com', password: 'password123')).to eq(nil)
    end

    it 'returns nil when password' do
      user = User.create(email: 'test@example.com', password: 'password123')

      expect(User.authenticate(email: 'test@example.com', password: 'wrong123')).to eq(nil)
    end

  end


end