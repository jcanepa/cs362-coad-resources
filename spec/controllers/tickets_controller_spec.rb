require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  let(:ticket) { create(:ticket) }
  let (:user) { create(:user, email: "foo@example.com", password: "password", role: 0) }
  let (:admin) { create(:user, email: "admin@example.com", password: "password", role: 1) }

#   describe 'GET ticket index' do
#     it { expect(get(:new)).to be_successful }
#   end

#   it "shows something in the browser" do
#     visit "/tickets/new"
#     expect(response).to include "Get Help"
#  end
end
