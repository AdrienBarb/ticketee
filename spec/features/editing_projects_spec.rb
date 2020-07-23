require "rails_helper"

RSpec.feature "Project managers can edit existing projects" do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, name: "Sublime Text 3") }

  before do
    login_as(user)
    assign_role!(user, :manager, project)

    visit "/"
    click_link "Sublime Text 3"
    click_link "Edit Project"
  end

  scenario "With valid attributes" do
    fill_in "Name", with: "Sublime Text 4 Beta"
    click_button "Update Project"

    expect(page).to have_content "Project has been updated."
    expect(page).to have_content "Sublime Text 4 Beta"
  end

  scenario "When updating with invalide attributes" do
    fill_in "Name", with: ""
    click_button "Update Project"

    expect(page).to have_content "Project has not been updated."
  end
end
