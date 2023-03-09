require 'rails_helper'

RSpec.describe 'Deleting a Region', type: :feature do
  context "admin deleting region" do
    it {
      user = create(:user, :admin)
      region = create(:region, :name => "Redmond")
      
      log_in_as(user)
  
      visit dashboard_path
  
      click_on("Regions")
      click_on("Redmond")
      click_on("Delete")
  
      expect(page).to have_content("Region Redmond was deleted. Associated tickets now belong to the 'Unspecified' region.")
    }
  end
end
