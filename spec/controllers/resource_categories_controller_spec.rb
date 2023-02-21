require 'rails_helper'

RSpec.describe ResourceCategoriesController, type: :controller do
    
    context "as an unauthenticated user" do

        describe "non logged in user " do
            it {expect(get(:index)).to redirect_to("/users/sign_in")}
        end

    end

    context "as an authenticated user" do

        describe "logged in non admin user" do
            let(:user) {create(:user)}
            before(:each) {sign_in(user)}
            it { expect(get(:index)).to redirect_to(dashboard_path)}
        end

    end

    context "as an authenticated admin" do

        let(:admin_approved_user) {create(:user, :admin)}
        before(:each) {sign_in(admin_approved_user)}

        describe "testing index with logged in admin user" do     
            it {expect(get(:index)).to be_successful}
        end

        describe "testing show with logged in admin user" do        
            it {
                resources = create(:resource_category, name: "name")
                expect(get :show, params: {id: resources.id}).to be_successful}
        end

    end

        
    
        
    
        
    
        
  
end
