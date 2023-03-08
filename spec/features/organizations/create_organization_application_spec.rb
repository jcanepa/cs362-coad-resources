require 'rails_helper'

RSpec.describe 'Creating an Organization Application', type: :feature do

  let(:user) { create(:user) }
  before(:each) {
    log_in_as(user)
    create(:resource_category)
    create(:user, :admin)
  }

  describe 'unaffiliated users can submit organization app' do

    it {
      # go to form
      visit(dashboard_path)
      click_on('Create Application')
      expect(current_path).to eq('/new_organization_application')

      # complete form
      choose('organization_liability_insurance_true')
      choose('organization_agreement_one_true')
      choose('organization_agreement_two_true')
      choose('organization_agreement_three_true')
      choose('organization_agreement_four_true')
      choose('organization_agreement_five_true')
      choose('organization_agreement_six_true')
      choose('organization_agreement_seven_true')
      choose('organization_agreement_eight_true')
      choose('organization_transportation_yes')
      check('organization_resource_category_ids_1')

      fill_in 'organization_primary_name', :with => 'foo'
      fill_in 'organization_name', :with => 'bar'
      fill_in 'organization_title', :with => 'baz'
      fill_in 'organization_phone', :with => '5411234567'
      fill_in 'organization_secondary_name', :with => 'baz'
      fill_in 'organization_secondary_phone', :with => '5417654321'
      fill_in 'organization_email', :with => 'hello@foo.org'
      fill_in 'organization_description', :with => 'corge'

      # submit form
      click_button('Apply')

      # success page
      expect(current_path).to eq('/organization_application_submitted')
      expect(page).to have_content('Application Submitted')
      click_on('Return To Dashboard')
      expect(current_path).to eq(dashboard_path)
    }
  end
end
