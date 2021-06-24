feature 'Viewing bookmarks' do
  # As a time-pressed user
  # So that I can quickly go to web sites I regularly visit
  # I would like to see a list of bookmarks

  scenario 'A user can see bookmarks' do
    con = PG.connect(dbname: 'bookmark_manager_test')
    con.exec("INSERT INTO bookmarks (url) VALUES ('http://www.makersacademy.com');")
    con.exec("INSERT INTO bookmarks (url) VALUES('http://www.destroyallsoftware.com');")
    con.exec("INSERT INTO bookmarks (url) VALUES('http://www.google.com');")

    visit('/bookmarks')

    expect(page).to have_content "http://www.makersacademy.com"
    expect(page).to have_content "http://www.destroyallsoftware.com"
    expect(page).to have_content "http://www.google.com"
  end
end