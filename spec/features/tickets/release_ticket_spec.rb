require 'rails_helper'

RSpec.describe 'Releasing a ticket by an', type: :feature do

  describe 'organizational user' do
    let(:user) { create(:user) }
    let(:ticket) { create(:ticket, :captured_by_approved_organization) }

    it {
      # join the approved organization who captured the ticket
      user.update(organization_id: ticket.organization_id)

      log_in_as(user)

      visit(dashboard_path)

      expect(page).to have_content('Dashboard')
      expect(page).to have_content('My Organization')
      expect(page).to have_content('Edit Organization')

      click_on('Tickets')

      expect(page).to have_content(ticket.name)

      click_on(ticket.name)

    }
  end

  describe 'admin' do
    let(:admin) { create(:user, :admin) }
  end

end
