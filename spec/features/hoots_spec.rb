require 'rails_helper'

describe "Hoots", js: true do

  def add_hoot(author, content)
    fill_in('author', with: author)
    fill_in('content', with: content)
    click_button('Hoot It')
  end

  before(:each) do
    Hoot.destroy_all
    Hoot.create!(
      author: "Hari",
      content: "Learnin' dat Capybara"
    )
  end

  it "shows a new hoot form when we visit the page" do
    visit(root_path)
    expect(page).to have_selector("input[type=text]")
    expect(page).to have_selector("textarea")
    expect(page).to have_selector("button.add")
  end

  it "shows all hoots content when we visit the page" do
    visit(root_path)
    expect(page).to have_content("Learnin' dat Capybara")
  end

  it "shows all hoots authors when we visit the page" do
    visit(root_path)
    expect(page).to have_content("Hari")
  end

  it "adds a hoot to the database when the new hoot form is used" do
    visit(root_path)
    add_hoot('JimBob', 'What is going on here?')
    expect(page).to have_content("What is going on here?")
  end

  it "deletes hoot when user clicks delete button" do
    visit(root_path)
    click_on('Delete Hoot')
    visit(root_path)
    expect(page).to have_no_content("Learnin' dat Capybara")
  end

  it "updates a tweet when edited" do
    visit(root_path)
    click_on('Edit Hoot')
    fill_in('edit-author', with: 'JoeBeans')
    fill_in('edit-content', with: 'Yo yo yo')
    click_on('Update Hoot')
    visit(root_path)
    expect(page).to have_content()
  end

end
