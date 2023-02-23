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
              :name => 'foo',
              :phone => 5105555555,
              :description => 'bar',
              :region_id => region.id,
              :resource_category_id => category.id
            }})
          expect(response).to redirect_to(ticket_submitted_path)
        }
    end

    describe 'POST #create malformed' do
      it {
        post(:create, params: { ticket: { name: nil} })
        expect(response).to render_template(:new)
      }
    end

    # GET /tickets/:id
    describe 'GET #show' do
      it {
        get(
          :show, params: {id: ticket.id})
        expect(response).to redirect_to(dashboard_path)
        # TODO unauthenticated users shouldn't have a dashboard?
      }
    end

    # POST /tickets/:id/capture
    describe 'POST #capture' do
      it {
        post(:capture, params: {id: ticket.id})
        expect(response).to redirect_to(dashboard_path)
      }
    end

    # DELETE /tickets/:id
    describe 'DELETE #destroy' do
      it {
        delete(:destroy, params: {id: ticket.id})
        expect(response).not_to be_successful
      }
    end

  end

  context 'as an authenticated user' do

    context 'who is part of an approved organization' do
      let(:uncaptured_ticket) {
        create(
          :ticket,
          region_id: region.id,
          resource_category_id: category.id,
          organization_id: 99)}

      let(:organization_approved_user) { create(:user, :organization_approved_user) }
      before(:each) { sign_in(organization_approved_user) }

      # POST /tickets/:id/capture
      describe 'POST #capture' do
        it {
          post(:capture, params: {id: ticket.id})
          expect(response).to redirect_to(dashboard_path << '#tickets:open')
        }
      end

      describe 'POST #capture with invalid ID' do
        it {
          post(:capture, params: {id: uncaptured_ticket.id})
          expect(response).to render_template(:show)
        }
      end

      # POST /tickets/:id/release
      describe 'POST #release without organization access' do
        it {
          post(:release, params: {id: ticket.id})
          expect(response).to render_template(:show)
        }
      end

      # POST /tickets/:id/release
      describe 'POST #release with organization access' do
        it {
          organization_approved_user.organization_id = 1
          ticket.organization_id = 1
          ticket.save

          post(:release, params: {id: ticket.id})
          expect(response).to redirect_to(dashboard_path << '#tickets:organization')
        }
      end

      # PATCH /tickets/:id/close
      describe 'PATCH #close without organization access' do
        it {
          patch(:close, params: { id: ticket.id })
          expect(response). to render_template(:show)
        }
      end

      describe 'PATCH #close with organization access' do
        it {
          organization_approved_user.organization_id = 1
          ticket.organization_id = 1
          ticket.save

          patch(:close, params: { id: ticket.id })
          expect(response). to redirect_to(dashboard_path << '#tickets:organization')
        }
      end

    end

    context 'who is part of an unapproved organization' do
      let(:organization_unapproved_user) { create(:user, :organization_unapproved_user) }
      before(:each) { sign_in(organization_unapproved_user) }

      # POST /tickets/:id/release
      describe 'POST #release' do
        it {
          post(:release, params: {id: ticket.id})
          expect(response).to redirect_to(dashboard_path)
        }
      end
    end
  end

  context 'as an authenticated admin user' do
    let(:admin) { create(:user, :admin) }
    before(:each) { sign_in(admin) }

    # GET tickets/:id
    describe 'GET #show' do
      it {
        get(:show, params: {id: ticket.id})
        expect(response).to be_successful
      }
    end

    context 'who is part of an approved organization with ticket ownership' do

      let(:organization_approved_admin) { create(:user, :organization_approved_user, :admin) }
      before(:each) {
        sign_in(organization_approved_admin)
        organization_approved_admin.organization_id = 1
        ticket.organization_id = 1
        ticket.save
      }

      # POST /tickets/:id/release
      describe 'POST #release' do
        it {
          post(:release, params: {id: ticket.id})
          expect(response).to redirect_to(dashboard_path << '#tickets:captured')
        }
      end

      # PATCH /tickets/:id/close
      describe 'PATCH #close' do
        it {
          patch(:close, params: { id: ticket.id })
          expect(response). to redirect_to(dashboard_path << '#tickets:open')
        }
      end
    end

    # DELETE /tickets/:id
    describe 'DELETE #destroy' do
      it {
        delete(:destroy, params: {id: ticket.id})
        expect(response).to redirect_to(dashboard_path << '#tickets')
      }
    end
  end
end
