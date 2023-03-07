require 'rails_helper'

RSpec.describe 'Creating an Organization Application', type: :feature do
  let(:user) { create(:user) }
  before(:each) { log_in_as(user) }

  describe 'new unaffiliated users can submit an organization application' do
    it {
      visit dashboard_path

      click_on('Create Application')
      expect(current_path).to eq('/new_organization_application')

      # fill in the form
      page.choose('organization_liability_insurance_true')
      page.choose('organization_agreement_one_true')
    }
  end
end
