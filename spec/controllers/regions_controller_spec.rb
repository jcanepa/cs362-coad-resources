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
      # create a region
      let(:region) { create(:region) }
      # pass its ID in as a param
      it {
        expect(
          get(
            :show,
            params: {id: region.id}))
          .to redirect_to(dashboard_path)
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
  end
end
