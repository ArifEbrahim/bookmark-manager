require './lib/database_connection.rb'
require 'uri'

class Bookmark
  def self.all
    result = DatabaseConnection.query("SELECT * FROM bookmarks;")
    result.map do |bookmark|
      Bookmark.new(url: bookmark['url'], title: bookmark['title'], id: bookmark['id'])      
    end
  end

  def self.create(url:, title:)
    return false unless is_url?(url)
    result = DatabaseConnection.query("INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}') RETURNING *;")
    Bookmark.new(url: result[0]['url'], title: result[0]['title'], id: result[0]['id'])    
  end

  attr_reader :url, :title, :id

  def initialize(url:, title:, id:)
    @url = url
    @title = title
    @id = id
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = #{id}")
  end

  def self.update(title:, url:, id:)
    result = DatabaseConnection.query("UPDATE bookmarks SET url = '#{url}', title = '#{title}' WHERE id = '#{id}' RETURNING *")
    Bookmark.new(title: result[0]['title'], url: result[0]['url'], id: result[0]['id'])    
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = '#{id}';")
    Bookmark.new(title: result[0]['title'], url: result[0]['url'], id: result[0]['id'])
  end

  private

  def self.is_url?(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end

end