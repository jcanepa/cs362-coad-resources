require 'rails_helper'

RSpec.describe 'Capturing a ticket', type: :feature do
  describe "Capturing a ticket with an admin" do
    it {
      user = create(:user, :organization_approved_user)
      organization = create(:organization)
      ticket = create(:ticket, name: "name", closed: false)
      ticket.reload
      user.organization.reload
      
      log_in_as(user)
      
      visit ticket_path(ticket.id)
      click_on("Capture")
      ticket.reload
      expect(ticket.captured?).to eq(true)
      
    }
  end
end
