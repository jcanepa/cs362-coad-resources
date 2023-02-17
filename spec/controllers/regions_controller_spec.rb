require 'rails_helper'

RSpec.describe RegionsController, type: :controller do

  context 'as an unauthenticated user' do
    let(:user) { create(:user) }

    describe 'GET #index' do
      it {
        expect(get(:index)).to redirect_to("/users/sign_in")
      }
    end
  end

  context 'as an authenticated user' do
    let(:user) { create(:user) }
    before(:each) { sign_in(user) }

    describe 'GET #index' do
      it {
        expect(get(:index)).to redirect_to(dashboard_path)
      }
    end

    describe 'GET #show' do
      # create a region to use its ID as a URL param
      let(:region) { create(:region) }
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
