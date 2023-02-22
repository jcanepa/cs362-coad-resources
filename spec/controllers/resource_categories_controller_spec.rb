require 'rails_helper'

RSpec.describe ResourceCategoriesController, type: :controller do
    
    context "as an unauthenticated user" do

        describe "testing index with unauthenticated user" do
            it {expect(get(:index)).to redirect_to("/users/sign_in")}
        end

        describe "testing show with unauthenticated user" do
            it {
                resources = create(:resource_category, name: "name")
                expect(get :show, params: {id: resources.id}).to redirect_to("/users/sign_in")
            }
        end

        describe "testing new with unauthenticated user" do
            it {expect(get(:new)).to redirect_to("/users/sign_in")}
        end

        describe "testing create with unauthenticated user" do
            it {expect(post(:create)).to redirect_to("/users/sign_in")}
        end

    end

    context "as an authenticated user" do
        let(:user) {create(:user)}
        before(:each) {sign_in(user)}

        describe "testing index with authenticated user" do
            it {expect(get(:index)).to redirect_to(dashboard_path)}
        end

        describe "testing show with authenticated user" do
            it {
                resources = create(:resource_category, name: "name")
                expect(get :show, params: {id: resources.id}). to redirect_to(dashboard_path)
            }
        end

        describe "testing new with authenticated user" do
            it {expect(get(:new)).to redirect_to(dashboard_path)}
        end

        describe "testing create with authenticated user" do
            it {expect(post(:create)).to redirect_to(dashboard_path)}
        end

    end

    context "as an authenticated admin" do

        let(:admin_approved_user) {create(:user, :admin)}
        before(:each) {sign_in(admin_approved_user)}

        describe "testing index with authenticated admin" do     
            it {expect(get(:index)).to be_successful}
        end

        describe "testing show with authenticated admin" do        
            it {
                resources = create(:resource_category, name: "name")
                expect(get :show, params: {id: resources.id}).to be_successful
            }
        end

        describe "testing new with authenticated admin" do
            it {expect(get(:new)).to be_successful}
        end

        describe "testing create with authenticated admin" do
            it {
                #post :create, params: {resource_category: {name: "name"}}
                post :create, params: {resource_category: attributes_for(:resource_category)}
                expect(response).to redirect_to(resource_categories_path)
            }
        end

        describe "testing successful activate with authenticated admin" do
            it {
                resources = create(:resource_category, name: "name")
                resources.deactivate
                patch :activate, params: {id: resources.id}
                expect(response).to redirect_to(resource_category_path)
                expect(flash[:notice]).to_not be_nil
            }
        end

    end

        
    
        
    
        
    
        
  
end
