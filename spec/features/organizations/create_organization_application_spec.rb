require 'rails_helper'

RSpec.describe 'Creating an Organization Application', type: :feature do
  let(:user) { create(:user) }
  before(:each) { log_in_as(user) }

  describe 'it can foo' do
    it {
      visit dashboard_path

      click_on('Create Application')
      expect(page).to have_current_path('/new_organization_application')
    }
  end
end
