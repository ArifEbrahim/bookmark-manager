require './lib/database_connection.rb'
require 'bcrypt'

class User

  def self.create(email:, password:)
    encrypted_password = BCrypt::Password.create(password)
    result = DatabaseConnection.query("INSERT INTO users (email, password) VALUES ('#{email}', '#{encrypted_password}') RETURNING *;")
    User.new(email: result[0]['email'], id: result[0]['id'])    
  end

  attr_reader :email, :id

  def initialize(email:, id:)
    @email = email
    @id = id
  end

  def self.find(id)
    return nil unless id 
    result = DatabaseConnection.query("SELECT * FROM users WHERE id = '#{id}';")
    User.new(email: result[0]['email'], id: result[0]['id'])
  end

  def self.authenticate(email:, password:)
    result = DatabaseConnection.query("SELECT * FROM users WHERE email = '#{email}'")
    return unless result.any?
    return unless BCrypt::Password.new(result[0]['password']) == password
    User.new(id: result[0]['id'], email: result[0]['email'])
  end

end