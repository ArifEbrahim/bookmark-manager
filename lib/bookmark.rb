require 'pg'

class Bookmark
  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'bookmark_manager_test')
    else
      con = PG.connect(dbname: 'bookmark_manager')
    end
    
    result = con.exec("SELECT * FROM bookmarks;")
    result.map do |bookmark|
      Bookmark.new(url: bookmark['url'], title: bookmark['title'], id: bookmark['id'])      
    end
  end

  def self.create(url:, title:)
    if ENV['ENVIRONMENT'] == 'test'
      con = PG.connect(dbname: 'bookmark_manager_test')
    else
      con = PG.connect(dbname: 'bookmark_manager')
    end

    result = con.exec("INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}') RETURNING *;")
    Bookmark.new(url: result[0]['url'], title: result[0]['title'], id: result[0]['id'])    
  end

  attr_reader :url, :title, :id

  def initialize(url:, title:, id:)
    @url = url
    @title = title
    @id = id
  end
end