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
  let(:user) { create(:user, :admin) }
  # instance double (not making a new user, a fake class)
  let(:user_double) { instance_double('User', admin?:true) }

  # context user groups
  describe 'foo' do
    it {

    }
  end

  let(:admin) { create(:user, :admin) }
  let(:org_approved_admin) { instance_doube('User', admin?:true, organization_id: Organization.new().id) }
end
