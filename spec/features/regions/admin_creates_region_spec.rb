require 'rails_helper'

RSpec.describe 'Creating a Region', type: :feature do
  let(:admin) {create(:user, :admin)}
  it "Creating a Region as an admin user" do

    log_in_as(admin)

    visit new_region_path

    #click_on("Add Region")
    fill_in("Name", with: "Las Vegas")
    click_on("Add Region")

    expect(current_path).to eq regions_path
    expect(page).to have_text("Las Vegas")
  end
end
