require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  let(:ticket) { create(:ticket) }

  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }

  let(:organization_approved_user) { create(:user, :organization_approved) }
  let(:organization_unapproved_user) { create(:user, :organization_unapproved) }

  context 'as an unauthenticated user' do
    describe 'GET #new' do
      it { expect(get(:new)).to be_successful }
    end
  end

  context 'as an authenticated user' do
    # describe 'GET #create' do
    #   it { expect(get(:create)).to be_successful }
    # end
  end

  context 'as an authenticated admin user' do
    # describe 'GET #show' do
    #   it { expect(get(:show)).to be_successful }
    # end
  end
end
