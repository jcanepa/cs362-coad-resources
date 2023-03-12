require 'rails_helper'

RSpec.describe 'Deleting a Ticket', type: :feature do
  let(:admin) { create(:user, :admin) }
  let(:ticket) { create(:ticket) }

  describe 'admin user deletes an existing ticket', js: true do

    it {
      log_in_as(admin)
      visit("tickets/#{ticket.id}")
      expect(page).to have_content("Ticket #{ticket.id}")

      click_link('Delete')

      # accepts alert
      page.driver.browser.switch_to.alert.accept

      # TODO: should be /dashboard#tickets but capybara doesn't like #anchors
      expect(page).to have_current_path('/dashboard')
      expect(page).to have_content("Ticket #{ticket.id} was deleted.")
    }
  end
end
