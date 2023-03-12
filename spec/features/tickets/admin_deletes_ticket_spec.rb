require 'rails_helper'

RSpec.describe 'Deleting a Ticket', type: :feature do
  let(:admin) { create(:user, :admin) }
  let(:ticket) { create(:ticket) }

  describe 'admin user deletes an existing ticket' do

    it {
      log_in_as(admin)
      visit("tickets/#{ticket.id}")
      expect(page).to have_content("Ticket #{ticket.id}")

      click_link('Delete')

      # implicitly accepts alert

      expect(page).to have_current_path('/dashboard') # TODO: should be /dashboard#tickets but capybara doesn't like #anchors
      expect(page).to have_content("Ticket #{ticket.id} was deleted.")
    }
  end
end
