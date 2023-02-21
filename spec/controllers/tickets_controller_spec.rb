require 'rails_helper'

RSpec.describe TicketsController, type: :controller do

  let(:category) { create(:resource_category) }
  let(:region) { create(:region) }
  let (:ticket) {
    create(
      :ticket,
      region_id: region.id,
      resource_category_id: category.id)}

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

    describe 'POST #create creates new resource' do
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

    # GET /tickets/:id
    describe 'GET #show DEBUG' do
      it {
        expect(ticket.id).to be > 0
      }
    end

  end

  context 'as an authenticated user' do

    context 'who is part of an approved organization' do
      let(:organization_approved_user) { create(:user, :organization_approved) }
      before(:each) { sign_in(organization_approved_user) }
    end

    context 'who is part of an unapproved organization' do
      let(:organization_unapproved_user) { create(:user, :organization_unapproved) }
      before(:each) { sign_in(organization_unapproved_user) }
    end
  end

  context 'as an authenticated admin user' do
    let(:admin) { create(:user, :admin) }
    before(:each) { sign_in(admin) }

    # GET tickets/:id
    # describe 'GET #show' do
    #   it {
    #     get(
    #       :show, params: {id: ticket.id})
    #     expect(response).to be_successful
    #   }
    # end
  end
end
