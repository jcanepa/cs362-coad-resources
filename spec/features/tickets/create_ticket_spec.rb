require 'rails_helper'

RSpec.describe 'Creating a Ticket', type: :feature do
    it "unapproved user can create a ticket" do
        region = create(:region)
        resource_category = create(:resource_category)

        visit root_path
        click_on("Get Help")

        fill_in('Full Name', with: 'John Doe')
        fill_in('Phone Number', with: '15415555555')
        fill_in('Description', with: 'I am having a super bad problem')
        select region.name, :from => "Region"
        select resource_category.name, :from => "Resource Category"

        click_on("Send this help request")
        expect(page).to have_content("Ticket Submitted")
    end
end
