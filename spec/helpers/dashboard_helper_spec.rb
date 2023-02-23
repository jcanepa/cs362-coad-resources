require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the DashboardHelper. For example:
#
# describe DashboardHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe DashboardHelper, type: :helper do

  context 'unauthenticated user' do
  end

  context 'authenticated user' do
  end

  context 'admin' do
    # let(:admin) { create(:user, :admin) }
    let(:user_double) { instance_double('User', admin?:true) } # doesn't make a new user, a fake class
    # let(:org_approved_admin) { instance_doube('User', admin?:true, organization_id: Organization.new().id) }

    describe 'gets the admin dashboard' do
      it {
        expect(helper.dashboard_for(user_double)).to eq 'admin_dashboard'
      }
    end
  end

end
