require 'rails_helper'

RSpec.describe 'Deleting a Resource Category', type: :feature do
    describe "As an admin" do
        it "can delete a resource category" do
            admin = create(:user, :admin)
            resource_category = create(:resource_category, name: 'name')

            log_in_as(admin)
            

            visit dashboard_path

            click_on('Categories')
            click_on('name')
            click_on('Delete')

            expect(page).to have_content('deleted')
        end
    end
end
