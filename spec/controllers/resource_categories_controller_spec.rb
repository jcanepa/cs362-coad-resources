require 'rails_helper'

RSpec.describe ResourceCategoriesController, type: :controller do
    
    let(:resource_category) {create(:resource_category)}

    context "as an unauthenticated user" do

        describe "testing index with unauthenticated user" do
            it {expect(get(:index)).to redirect_to("/users/sign_in")}
        end

        describe "testing show with unauthenticated user" do
            it {expect(get :show, params: {id: resource_category.id}).to redirect_to("/users/sign_in")}
        end

        describe "testing new with unauthenticated user" do
            it {expect(get(:new)).to redirect_to("/users/sign_in")}
        end

        describe "testing create with unauthenticated user" do
            it {expect(post(:create)).to redirect_to("/users/sign_in")}
        end

        describe "testing edit with unauthenticated user" do
            it {expect(get :edit, params: {id: resource_category.id}).to redirect_to("/users/sign_in")}
        end

        describe "testing update with unauthenticated user" do
            it {
                patch(
                    :update, params: {id: resource_category.id, resource_category: attributes_for(:resource_category)}
                )
                expect(response).to redirect_to("/users/sign_in")
            }
        end

        describe "testing activate with unauthenticated user" do
            it {
                patch(
                    :activate, params: {id: resource_category.id, resource_category: attributes_for(:resource_category)}
                )
                expect(response).to redirect_to("/users/sign_in")
            }
        end

        describe "testing deactivate with unauthenticated user" do
            it {
                patch(
                    :deactivate, params: {id: resource_category.id, resource_category: attributes_for(:resource_category)}
                )
                expect(response).to redirect_to("/users/sign_in")
            }
        end

        describe "testing destroy with unauthenticated user" do
            it {
                delete(
                    :destroy, params: {id: resource_category.id}
                )
                expect(response).to redirect_to("/users/sign_in")
            }
        end

    end

    context "as an authenticated user" do
        let(:user) {create(:user)}
        before(:each) {sign_in(user)}

        describe "testing index with authenticated user" do
            it {expect(get(:index)).to redirect_to(dashboard_path)}
        end

        describe "testing show with authenticated user" do
            it {expect(get :show, params: {id: resource_category.id}). to redirect_to(dashboard_path)}
        end

        describe "testing new with authenticated user" do
            it {expect(get(:new)).to redirect_to(dashboard_path)}
        end

        describe "testing create with authenticated user" do
            it {expect(post(:create)).to redirect_to(dashboard_path)}
        end

        describe "testing edit with authenticated user" do
            it {expect(get :edit, params: {id: resource_category.id}).to redirect_to(dashboard_path)}
        end

        describe "testing update with authenticated user" do
            it {
                patch(
                    :update, params: {id: resource_category.id, resource_category: attributes_for(:resource_category)}
                )
                expect(response).to redirect_to(dashboard_path)
            }
        end

        describe "testing activate with authenticated user" do
            it {
                patch(
                    :activate, params: {id: resource_category.id, resource_category: attributes_for(:resource_category)}
                )
                expect(response).to redirect_to(dashboard_path)
            }
        end

        describe "testing deactivate with authenticated user" do
            it {
                patch(
                    :deactivate, params: {id: resource_category.id, resource_category: attributes_for(:resource_category)}
                )
                expect(response).to redirect_to(dashboard_path)
            }
        end

        describe "testing destroy with authenticated user" do
            it {
                delete(
                    :destroy, params: {id: resource_category.id}
                )
                expect(response).to redirect_to(dashboard_path)
            }
        end

    end

    context "as an authenticated admin" do

        let(:admin_approved_user) {create(:user, :admin)}
        before(:each) {sign_in(admin_approved_user)}

        describe "testing index with authenticated admin" do     
            it {expect(get(:index)).to be_successful}
        end

        describe "testing show with authenticated admin" do        
            it {expect(get :show, params: {id: resource_category.id}).to be_successful}
        end

        describe "testing new with authenticated admin" do
            it {expect(get(:new)).to be_successful}
        end

        describe "testing create with authenticated admin" do
            it {
                post :create, params: {resource_category: attributes_for(:resource_category)}
                expect(response).to redirect_to(resource_categories_path)
            }
        end

        describe "testing failed create" do
            it {
                post :create, params: {resource_category: {name: nil}}
                expect(response).to render_template(:new)
            }
        end

        describe "testing edit with authenticated admin" do
            it {expect(get :edit, params: {id: resource_category.id}).to be_successful}
        end

        describe "testing update with authenticated admin" do
            it {
                patch(
                    :update, params: {id: resource_category.id, resource_category: attributes_for(:resource_category)}
                )
                expect(response).to redirect_to(resource_category_path)
                expect(flash[:notice]).to_not be_nil
            }
        end

        describe "testing failed update with authenticated admin" do
            it {
                expect_any_instance_of(ResourceCategory).to receive(:save).and_return(false)
                patch :update, params: {id: resource_category.id, resource_category: attributes_for(:resource_category)}
                expect(response).to render_template(:edit)
            }
        end

        describe "testing successful activate with authenticated admin" do
            it {
                patch :activate, params: {id: resource_category.id, resource_category: attributes_for(:resource_category)}
                expect(response).to redirect_to(resource_category_path)
                expect(flash[:notice]).to_not be_nil
            }
        end

        describe "testing failed activate with authenticated admin" do
            it {
                expect_any_instance_of(ResourceCategory).to receive(:save).and_return(false)
                patch :activate, params: {id: resource_category.id, resource_category: attributes_for(:resource_category)}
                #expect(response).to render_template(resource_category_path)
                expect(flash[:alert]).to_not be_nil
            }
        end

        describe "testing deactivate with authenticated admin" do
            it {
                patch(
                    :deactivate, params: {id: resource_category.id, resource_category: attributes_for(:resource_category)}
                )
                expect(response).to redirect_to(resource_category_path)
                expect(flash[:notice]).to_not be_nil
            }
        end

        describe "testing failed deactivate with authenticated admin" do
            it {
                expect_any_instance_of(ResourceCategory).to receive(:save).and_return(false)
                patch :deactivate, params: {id: resource_category.id, resource_category: attributes_for(:resource_category)}
                #expect(response).to render_template(resource_category_path)
                expect(flash[:alert]).to_not be_nil
            }
        end

        describe "testing destroy with unauthenticated user" do
            it {
                delete(
                    :destroy, params: {id: resource_category.id}
                )
                expect(response).to redirect_to(resource_categories_path)
            }
        end

    end
  
end
