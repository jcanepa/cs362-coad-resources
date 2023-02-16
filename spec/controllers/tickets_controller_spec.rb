require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  let(:ticket) { create(:ticket) }
  let(:user) { create(:user, email: "foo@example.com", password: "password", role: 0) }
  let(:admin) { create(:user, email: "admin@example.com", password: "password", role: 1) }
  let(:organization_approved_user) { create(:user, :organization_approved) }
  let(:organization_unapproved_user) { create(:user, :organization_unapproved) }

  describe 'GET new ticket' do
    it { expect(get(:new)).to be_successful }
  end

  # describe 'GET create ticket' do
  #   it { expect(get(:create)).to be_successful }
  # end

  # describe 'GET show ticket' do
  #   it { expect(get(:show)).to be_successful }
  # end
end
