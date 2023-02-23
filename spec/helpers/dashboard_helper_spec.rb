require 'rails_helper'

RSpec.describe DashboardHelper, type: :helper do

  context 'unassociated user' do
    let(:user) { create(:user) }
    it 'gets the default dashboard' do
      expect(
        helper.dashboard_for(user))
        .to eq 'create_application_dashboard'
    end
  end

  context 'organizational user' do
    o = Organization.new
    let(:organizational_user) {
      instance_double('User', admin?: false, organization: o) }

    it 'gets the organization submitted dashboard' do
      expect(helper.dashboard_for(organizational_user))
      .to eq 'organization_submitted_dashboard'
    end

    it 'gets the organization approved dashboard' do
      o.approve
      expect(helper.dashboard_for(organizational_user))
      .to eq 'organization_approved_dashboard'
    end
  end

  context 'admin' do
    let(:admin) { create(:user, :admin) }

    it 'gets the admin dashboard' do
      expect(
        helper.dashboard_for(admin))
        .to eq 'admin_dashboard'
    end
  end

end
