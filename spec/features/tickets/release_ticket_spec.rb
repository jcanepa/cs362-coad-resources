require 'rails_helper'

RSpec.describe 'Releasing a ticket by an', type: :feature do

  describe 'organizational user' do
    let(:user) { create(:user, :organization_approved_user) }
    let(:ticket) { create(:ticket, :captured_by_organization) }

    it {
      log_in_as(user)
    }
  end

  describe 'admin' do
    let(:admin) { create(:user, :admin) }
  end

end
