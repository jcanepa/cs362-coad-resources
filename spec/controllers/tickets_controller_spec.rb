require 'rails_helper'

RSpec.describe TicketsController, type: :controller do

  # Dependencies
  let(:category) { ResourceCategory.create(name: 'Test') }
  let(:region) { create(:region, name: "Foo") }
  let(:organization) { Organization.create(name: "@", email: "foo@test.com", phone: 5413983298, primary_name: '@', secondary_name: '@', secondary_phone: 5555555555) }

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
            params: { ticket: {
              :name => "Foo",
              :phone => 5555555555,
              :region_id => region.id,
              :resource_category_id => category.id
            } })
          expect(response).to redirect_to(ticket_submitted_path)
        }
    end

    describe 'POST #create _templates :new if malformed' do
      it {
        post(:create, params: { ticket: { name: nil} })
        expect(response).to render_template(:new)
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

    # # GET tickets/:id
    # describe 'GET #show' do
    #   it {
    #     get(
    #       :show, params: {id: ticket.id})
    #     expect(response).to be_successful
    #   }
    # end
  end
end
