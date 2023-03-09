require 'rails_helper'

RSpec.describe 'Closing a ticket', type: :feature do
    let(:admin) {create(:user, :admin)}
    let(:ticket) {create(:ticket)}

    it "admin can close a ticket" do
        #ticket = create(:ticket, name: 'Super Test')
        log_in_as(admin)
        visit("tickets/#{ticket.id}")
        click_on("Close")
        visit("tickets/#{ticket.id}")

        expect(page).to have_content("Closed")
    end

end
