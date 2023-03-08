require 'rails_helper'

RSpec.describe 'Creating an Organization Application', type: :feature do
  let(:user) { create(:user) }
  before(:each) {
    log_in_as(user)
    create(:resource_category)
  }

  describe 'unaffiliated users can submit organization app' do
    it {
      visit(dashboard_path)
      click_on('Create Application')
      expect(current_path).to eq('/new_organization_application')

      # fill in the form

      # fill_in('First Name', with: 'John')
      # fill_in('Password', with: 'Seekrit')
      # fill_in('Description', with: 'Really Long Text...')
      # choose('A Radio Button')
      # check('A Checkbox')
      # uncheck('A Checkbox')
      # attach_file('Image', '/path/to/image.jpg')
      # select('Option', from: 'Select Box')

      choose('organization_liability_insurance_true')
      choose('organization_agreement_one_true')
      check('organization_resource_category_ids_1')
      fill_in 'organization_primary_name', :with => 'foo'

      click_button('Apply')
    }
  end
end
