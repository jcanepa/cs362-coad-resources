require 'rails_helper'

RSpec.describe 'Releasing a ticket by an', type: :feature do

  let(:ticket) { create(:ticket) }

  describe 'organizational user' do
    let(:organization_approved_user) { create(:user, :organization_approved_user) }

    it {
      log_in_as(organization_approved_user)
    }
  end

  describe 'admin' do
    let(:admin) { create(:user, :admin) }

  end

end
