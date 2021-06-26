feature 'Adding a new bookmark' do
  scenario 'A user can add a bookmark to Bookmark Manager' do
    visit('/bookmarks/new')
    fill_in('url', with: 'http://www.example.com')
    fill_in('title', with: 'Test bookmark')
    click_button('Submit')

    expect(page).to have_link('Test bookmark', href: 'http://www.example.com')
  end
end