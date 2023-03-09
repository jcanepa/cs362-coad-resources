require 'rails_helper'

RSpec.describe 'Deleting a Ticket', type: :feature do
  let(:admin) { create(:user, :admin) }
  let(:ticket) { create(:ticket) }

  # it 'admin user deletes an existing ticket' do
  #   log_in_as(admin)
  #   visit('tickets/' + ticket.id)
  #   expect(page).to have_content('Ticket' + ticket.id)
  # end
end
