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

  # context 'authenticated user' do
  #   let(:organizational_user) { instance_double('User', organization_id: Organization.new.id) }

  #   describe 'gets the organizationsubmitted dashboard' do
  #     it {
  #       expect(helper.dashboard_for(organizational_user)).to eq 'organization_submitted_dashboard'
  #     }
  #   end
  # end

  context 'admin' do
    let(:admin) { instance_double('User', admin?: true) }

    describe 'gets the admin dashboard' do
      it {
        expect(helper.dashboard_for(admin)).to eq 'admin_dashboard'
      }
    end
  end

end
