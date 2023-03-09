require 'rails_helper'

RSpec.describe 'Updating an Organization', type: :feature do
  describe "An approved user updating an Organization" do
    it {
      user = create(:user, :organization_approved_user)
      #organization = create(:organization)

      log_in_as(user)
      
      # Navigate to the dashboard path
      visit dashboard_path
      

      # Navigate to the edit organization page
      click_on("Edit Organization")

      # Fill in fields with new values
      fill_in("Name", with: "New Name")
      fill_in("Phone", with: "555-555-5555")
      fill_in("Email", with: "newemail@domain.com")
      fill_in("Description", with: "New description")
      click_on("Update Resource")

      # Expect the page to have the new values
      expect(page).to have_content("New Name")
      expect(page).to have_content("newemail@domain.com")
      expect(page).to have_content("New description")

      # Expect the current path to the organization 1 path
      expect(current_path).to eq("/organizations/1")
    }
  end
end
