require './lib/bookmark.rb'
require 'database_helpers'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      # Add the test data
      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers Academy")
      Bookmark.create(url: "http://www.destroyallsoftware.com", title: "Destroy All Software")
      Bookmark.create(url: "http://www.google.com", title: "Google")
   
      bookmarks = Bookmark.all
   
      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers Academy'
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
    end
  end

  describe '.create' do
    it 'creates a new bookmark' do 
      bookmark = Bookmark.create(url: 'http://www.example.com', title: 'Test bookmark')
      persisted_data = persisted_data(id: bookmark.id)

      expect(bookmark).to be_a(Bookmark)
      expect(bookmark.id).to eq(persisted_data['id'])
      expect(bookmark.title).to eq('Test bookmark')
      expect(bookmark.url).to eq('http://www.example.com')
    end
  end

  describe '.delete' do
    it 'deletes a bookmark' do
      bookmark = Bookmark.create(title: 'Makers Academy', url: 'http://www.makersacademy.com')
      Bookmark.delete(id: bookmark.id)

      bookmarks = Bookmark.all
      expect(bookmarks.length).to eq(0)
    end
  end

  describe '.update' do
    it 'updates a bookmark' do
      bookmark = Bookmark.create(url: 'http://www.example.com', title: 'Test bookmark')
      updated_bookmark = Bookmark.update(title: 'Makers Academy', url: 'http://www.makersacademy.com', id: bookmark.id)
    
      expect(updated_bookmark).to be_a(Bookmark)
      expect(updated_bookmark.id).to eq(bookmark.id)
      expect(updated_bookmark.title).to eq('Makers Academy')
      expect(updated_bookmark.url).to eq('http://www.makersacademy.com')
    end
  end
 
  describe '.find' do
    it 'returns the requested bookmark' do
      bookmark = Bookmark.create(url: 'http://www.example.com', title: 'Test bookmark')
      result = Bookmark.find(id: bookmark.id)

      expect(result).to be_a(Bookmark)
      expect(result.id).to eq(bookmark.id)
      expect(result.url).to eq('http://www.example.com')
      expect(result.title).to eq('Test bookmark')


    end
  end
end