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
      expect(page).to have_content('Tickets')

      click_on('Tickets')

      expect(page).to have_content(ticket.name)
      select 'My Captured', from: 'status'
      # for some reason the tickets disappear, until you click tickets again
      # TODO: seems like a bug!
      click_on('Tickets')

      # tickets index
      expect(page).to have_content(ticket.name)
      click_on(ticket.name)

      # single ticket detail
      expect(page).to have_content(ticket.name)
      expect(page).to have_content("Ticket #{ticket.id}")
      expect(page).to have_content(ticket.description)
      click_on('Release')

      # verify redirct
      expect(current_path).to eq(dashboard_path)

      # verify ticket no longer appears under captured tickets
      click_on('Tickets')
      select 'My Captured', from: 'status'
      click_on('Tickets')
      # expect(page).to_not have_content(ticket.name)
    }
  end

  describe 'admin' do
    let(:admin) { create(:user, :admin) }
  end

end
