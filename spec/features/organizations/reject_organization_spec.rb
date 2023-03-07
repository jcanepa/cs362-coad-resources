require 'rails_helper'

RSpec.describe 'Rejecting an organization', type: :feature do
  describe "admin rejecting an organization" do
    it "can be done from the dashboard" do 
      user = create(:user, :admin)
      organization = create(:organization)
      log_in_as(user)

      visit dashboard_path

      click_on("Organization")
      click_on("Pending")
      click_on("Review")
      click_on("Reject")

      expect(organization.reload.approved?).to be false
    end
  end
end
