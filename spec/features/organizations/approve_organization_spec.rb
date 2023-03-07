require 'rails_helper'

RSpec.describe 'Approving an organization', type: :feature do
  describe "admin approving an organization" do
    it 'can be done from the dashboard' do
      user = create(:user, :admin)
      organization = create(:organizations)
      log_in_as(user)

      visit dashboard_path

      click_on('Organizations')
      click_on('Pending')
      click_on('Review')
      click_on('Approve')

      expect(organization.reload.approved?).to be true

    end

    it "cannot be done by a non-admin user" do
      organization = create(:organization, :approved)
      not_approved_org = create(:organization)
      user = create(:user, organization: organization)
      log_in_as(user)

      visit dashboard_path
      visit organization_path(id: not_approved_org.id)
      expect(page).not_to have_content 'Approve'
    end
  end
end
