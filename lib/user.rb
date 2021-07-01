require './lib/database_connection.rb'

class User

  def self.create(email:, password:)
    result = DatabaseConnection.query("INSERT INTO users (email, password) VALUES ('#{email}', '#{password}') RETURNING *;")
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
    result = DatabaseConnection.query("SELECT * FROM users WHERE email = '#{email}';")
    User.new(id:result[0]['id'], email:result[0]['email'])
  end

end