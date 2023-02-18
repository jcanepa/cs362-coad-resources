require 'rails_helper'

RSpec.describe TicketsController, type: :controller do

  context 'as an unauthenticated user' do
      let(:user) { create(:user) }
      describe 'GET #new' do
      it { expect(get(:new)).to be_successful }
    end
  end

  context 'as an authenticated user' do
    describe 'GET #new' do
      it { expect(get(:new)).to be_successful }
    end

    context 'who is part of an approved organization' do
      let(:organization_approved_user) { create(:user, :organization_approved) }
    end

    context 'who is part of an unapproved organization' do
      let(:organization_unapproved_user) { create(:user, :organization_unapproved) }
    end
  end

  context 'as an authenticated admin user' do
    let(:admin) { create(:user, :admin) }
    describe 'GET #new' do
      it { expect(get(:new)).to be_successful }
    end
    # describe 'GET #show' do
    #   it { expect(get(:show)).to be_successful }
    # end
  end
end
