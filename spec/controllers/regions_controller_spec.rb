require 'rails_helper'

RSpec.describe RegionsController, type: :controller do

  let(:region) { create(:region) }

  context 'as an unauthenticated user' do
    # all region routes redirect unauthenticated users to login
    let(:user) { create(:user) }

    # GET /
    describe 'GET #index' do
      it {
        expect(get(:index))
        .to redirect_to("/users/sign_in")
      }
    end

    # GET /regions/:id
    describe 'GET #show' do
      it {
        post(
          :show, params: {id: region.id})
        expect(response).to redirect_to('/users/sign_in')
      }
    end

    # GET /regions/new
    describe 'GET #new' do
      it {
        expect(get(:new)) .to redirect_to("/users/sign_in")
      }
    end

    # POST /regions
    describe "POST #create" do
      it {
        post(
          :create,
          params: { region: attributes_for(:region) })
        expect(response).to redirect_to('/users/sign_in')
      }
    end

    # GET /regions/:id/edit
    describe 'GET #edit' do
      it {
        expect(
          get(
            :edit, params: {id: region.id}))
        .to redirect_to("/users/sign_in")
      }
    end

    # PATCH /regions/:id
    describe 'PATCH #update' do
      it {
        patch(
          :update, params: {id: region.id})
        expect(response).to redirect_to("/users/sign_in")
      }
    end
  end

  context 'as an authenticated user' do
    let(:user) { create(:user) }
    before(:each) { sign_in(user) }

    # GET /
    describe 'GET #index' do
      it {
        expect(get(:index)).to redirect_to(dashboard_path)
      }
    end

    describe 'GET #show' do
      it {
        expect(
          get(
            :show,
            params: {id: region.id}))
          .to redirect_to(dashboard_path)
      }
    end

    describe "POST #create" do
      it {
        post(
          :create,
          params: { region: attributes_for(:region) })
        expect(response).to redirect_to(dashboard_path)
      }
    end
  end

  context 'as an authenticated admin' do
    let(:user) { create(:user, :admin) }
    before(:each) { sign_in(user) }

    # GET /
    describe 'GET #index' do
      it {
        expect(get(:index)).to be_successful
      }
    end

    describe "POST #create" do
      it {
        # post data
        post(
          :create,
          params: { region: attributes_for(:region) })
        # expect
        expect(response).to redirect_to(regions_path)
      }
    end
  end

end
