require 'rails_helper'

RSpec.describe TicketsController, type: :controller do

  context 'as an unauthenticated user' do
    # GET /tickets/new
    describe 'GET #new' do
      it { expect(get(:new)).to be_successful }
    end

    # POST /tickets
    describe 'POST #create' do
        it {
          post(
            :create,
            :params => { :ticket => {
              :name => "Foo",
              :phone => 5555555555,
              :description => "Bar.",
              :region_id => 1,
              :resource_category_id => 1
            } })
          expect(response).to redirect_to(ticket_submitted_path)
        }
    end
  end

  context 'as an authenticated user' do
    let(:user) { create(:user) }
    before(:each) { sign_in(user) }

    context 'who is part of an approved organization' do
      let(:organization_approved_user) { create(:user, :organization_approved) }
    end

    context 'who is part of an unapproved organization' do
      let(:organization_unapproved_user) { create(:user, :organization_unapproved) }
    end
  end

  context 'as an authenticated admin user' do
    let(:admin) { create(:user, :admin) }

    # describe 'GET #show' do
    #   it { expect(get(:show)).to be_successful }
    # end
  end
end
