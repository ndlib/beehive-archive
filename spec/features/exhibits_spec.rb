require "rails_helper"
require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

feature "exhibit management" do

  before(:each) do
    @user = User.new(username: 'jhartzle')
    @user.save!
    login_as @user
  end

  scenario "Exhibits can be created" do
    visit "/exhibits"

    click_link "New"
    expect(page).to have_text("New Exhibit")

    fill_in "Title", with: "Text Exhibit"
    click_button "Save"
    expect(page).to have_text("Text Exhibit")
  end


  scenario "Exhibits can be deleted" do

  end

end
