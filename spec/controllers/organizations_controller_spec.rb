require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do

  #before(:each) {sign_in(organization_approved_user)}

  describe "index with signed in approved user" do
    let(:organization_approved_user) { create(:user, :organization_approved_user)}
    let(:organization) {create(:organization)}
    before(:each) {sign_in(organization_approved_user)}
    it { expect(get(:index)).to be_successful }
  end

  describe "index with non signed in user" do
    let(:organization_approved_user) {create(:user, :organization_approved_user)}
    it {expect(get(:index)).to redirect_to("/users/sign_in")}
  end

  describe "new with signed in approved user" do
    let(:organization_approved_user) {create(:user, :organization_approved_user)}
    before(:each) {sign_in(organization_approved_user)}
    it {expect(get(:new)).to_not be_successful}
  end

  describe "new with not signed in approved user" do
    let(:organization_approved_user) {create(:user, :organization_approved_user)}
    it {expect(get(:new)).to_not be_successful}
  end

  describe "new with signed in user with no organization" do
    let(:organization_unapproved_user) {create(:user, :no_organization_user)}
    before(:each) {sign_in(organization_unapproved_user)}
    it {expect(get(:new)).to be_successful}
  end

  describe "unnaproved user with an organization" do
    let(:organization_unapproved_user) {create(:user, :organization_unapproved_user)}
    before(:each) {sign_in(organization_unapproved_user)}
    it {expect(get(:new)).to_not be_successful}
  end

  describe "new with approved non signed in user with an organization" do
    let(:organization_approved_user) {create(:user, :organization_unapproved_user)}
    it {expect(get(:new)).to_not be_successful}
  end

  describe "create with signed in approved admin user" do
    let(:organization_approved_user) {create(:user, :organization_approved_user, :admin)}
    before(:each) {sign_in(organization_approved_user)}
    it {expect(post(:create)).to_not be_successful}
  end

  describe "create with signed in approved non admin user" do
    let(:organization_approved_user) {create(:user, :organization_approved_user)}
    before(:each) {sign_in(organization_approved_user)}
    it {expect(post(:create)).to_not be_successful}
  end

  describe "create with signed in no organization user" do
    let(:no_organization_user) {create(:user, :no_organization_user)}
    let(:organization) {create(:organization)}
    before(:each) {sign_in(no_organization_user)}

    it {
      organization = create(:organization, name: 'Old name')
      organization.reload
      expect_any_instance_of(UserMailer).to receive(:new_organization_application).and_return(nil)
      expect(post :create, params: { id: organization.id, organization: { name: "a_brand_new",
                                    status: :approved,
                                    email: "daltons2252@gmail.com",
                                    phone: "555-555-5555",
                                    primary_name: "sup dude",
                                    secondary_name: "second_name",
                                    secondary_phone: "666-666-6666" } }).to \
        redirect_to(organization_application_submitted_path)}
  end

  describe "edit with a non signed in approved user" do
    let(:organization_approved_user) {create(:user, :organization_approved_user, :admin)}
    before(:each) {sign_in(organization_approved_user)}

    it {
      organization = create(:organization, name: 'Old name')
      organization.reload
      expect(get :edit, params: { id: organization.id }).to render_template(:edit)}
  end

  describe "create with signed in no organization user with inproper organization fields" do
    let(:no_organization_user) {create(:user, :no_organization_user)}
    let(:organization) {create(:organization)}
    before(:each) {sign_in(no_organization_user)}

    it {
      organization = create(:organization, name: 'Old name')
      organization.reload
      expect(post :create, params: { id: organization.id, organization: { name: "a_brand_new",
                                    status: :approved,
                                    email: "dalton" } }).to render_template(:new)}

  end

  describe "Checking update with logged in admin user" do

    let(:organization_approved_user) { create(:user, :organization_approved_user, :admin)}
    before(:each) {sign_in(organization_approved_user)}
    it 'updates an organization' do
      organization = create(:organization, name: 'Old name')
      organization.reload
      expect(put :update, params: { id: organization.id, organization: { name: "new_name", status: :approved } }).to redirect_to(organization_path(id: organization.id))
    end

    let(:organization_unapproved_user) { create(:user, :organization_unapproved_user, :admin)}
    before(:each) {sign_in(organization_approved_user)}
    it 'fails to update an organization' do
      organization = create(:organization, name: 'Old name', status: :approved)
      organization.reload
      expect(put :update, params: { id: organization.id, organization: { name: "", status: :rejected } }).to render_template(:edit)
    end

  end

  describe "a signed in user editing a organization is successful" do
    let(:organization_approved_user) { create(:user, :organization_approved_user)}
    before(:each) {sign_in(organization_approved_user)}
    it "redirects to dashboard path" do
      organization = create(:organization)
      organization.reload
      expect(get :edit, params: {id: organization.id}).to be_successful
    end
  end

  describe "non signed in user " do
    let(:organization_approved_user) { create(:user, :organization_approved_user)}
    #before(:each) {sign_in(organization_approved_user)}
    it "redirects to user sign in" do
      organization = create(:organization)
      organization.reload
      expect(get :edit, params: {id: organization.id}).to redirect_to("/users/sign_in")
    end
  end

  describe "show with an unapproved signed in user " do
    let(:organization_unapproved_user) { create(:user, :organization_unapproved_user)}
    before(:each) {sign_in(organization_unapproved_user)}
    it "redirects to dashboard path" do
      organization = create(:organization)
      organization.reload
      expect(get :show, params: {id: organization.id}).to redirect_to(dashboard_path)
    end
  end

  describe "show with an unapproved not signed in user " do
    let(:organization_unapproved_user) { create(:user, :organization_unapproved_user)}
    it "redirects to dashboard path" do
      organization = create(:organization)
      organization.reload
      expect(get :show, params: {id: organization.id}).to redirect_to("/users/sign_in")
    end
  end

  describe "show with a admin" do
    let(:organization_admin_user) {create(:user, :organization_approved_user, :admin)}
    before(:each) {sign_in(organization_admin_user)}
    it "redirects to dashboard path" do
      organization = create(:organization)
      organization.reload
      expect(get :show, params: {id: organization.id}).to render_template(:show)
    end
  end

  describe "approve" do
    let(:organization_approved_user) {create(:user, :organization_approved_user, :admin)}
    before(:each) {sign_in(organization_approved_user)}
    it "approved user" do
      organization = create(:organization)
      organization.reload
      expect(post :approve, params: { id: organization.id, organization: {
        name: "a_brand_new",
        status: :approved,
        email: "daltons2252@gmail.com",
        phone: "555-555-5555",
        primary_name: "sup dude",
        secondary_name: "second_name",
        secondary_phone: "666-666-6666" } }).to \
        redirect_to(organizations_path)
    end
  end

  describe "approve with non-admin users" do
    let(:organization_approved_user) {create(:user, :organization_approved_user)}
    before(:each) {sign_in(organization_approved_user)}
    it "approved user" do
      organization = create(:organization)
      organization.reload
      expect(post :approve, params: { id: organization.id, organization: {
        name: "a_brand_new",
        status: :approved,
        email: "daltons2252@gmail.com",
        phone: "555-555-5555",
        primary_name: "sup dude",
        secondary_name: "second_name",
        secondary_phone: "666-666-6666" } }).to_not be_successful
    end
  end

  describe "approve with non-admin users" do
    let(:organization_approved_user) {create(:user, :organization_approved_user)}
    it "approved user" do
      organization = create(:organization)
      organization.reload
      expect(post :approve, params: { id: organization.id, organization: {
        name: "a_brand_new",
        status: :approved,
        email: "daltons2252@gmail.com",
        phone: "555-555-5555",
        primary_name: "sup dude",
        secondary_name: "second_name",
        secondary_phone: "666-666-6666" } }).to redirect_to("/users/sign_in")
    end
  end

  describe "approve with admin users" do
    let(:organization_approved_user) {create(:user, :organization_approved_user, :admin)}
    before(:each) {sign_in(organization_approved_user)}
    it "approved user" do
      allow_any_instance_of(Organization).to receive(:save).and_return(false)
      organization = create(:organization, status: :submitted)
      organization.reload
      allow(Organization).to receive(:find).and_return(organization)
      expect(post :approve, params: { id: organization.id }).to \
      redirect_to(organization_path(id: organization.id))
    end
  end

  describe "Checking update with logged in non admin user" do

    let(:organization_approved_user) { create(:user, :organization_approved_user)}
    before(:each) {sign_in(organization_approved_user)}
    it 'updates an organization' do
      organization = create(:organization, name: 'Old name')
      organization.reload
      expect(put :update, params: { id: organization.id, organization: { name: "new_name", status: :approved } }).to redirect_to(organization_path(id: organization.id))
    end

    let(:organization_unapproved_user) { create(:user, :organization_unapproved_user)}
    before(:each) {sign_in(organization_approved_user)}
    it 'fails to update an organization' do
      organization = create(:organization, name: 'Old name', status: :approved)
      organization.reload
      expect(put :update, params: { id: organization.id, organization: { name: "", status: :rejected } }).to render_template(:edit)
    end

  end

  describe "organization with a user that is not signed in" do
    let(:organization_approved_user) { create(:user, :organization_approved_user)}
    it 'updates an organization' do
      organization = create(:organization, name: 'Old name')
      organization.reload
      expect(put :update, params: { id: organization.id, organization: { name: "new_name", status: :approved } }).to redirect_to("/users/sign_in")
    end
  end

  describe "reject" do
    let(:organization_approved_user) {create(:user, :organization_approved_user)}
    before(:each) {sign_in(organization_approved_user)}
    it "rejects and organization with approved user" do
      #let(:organization) {create(:organization, status: :submitted)}

      organization = create(:organization, status: :submitted)
      organization.reload

      expect(post :reject, params: {id: organization.id}).to_not be_successful
    end
  end

  describe "reject" do
    let(:organization_unapproved_user) {create(:user, :organization_unapproved_user)}
    #before(:each) {sign_in(organization_unapproved_user)}
    it "rejects and organization with approved user" do

      organization = create(:organization, status: :submitted)
      organization.reload

      expect(post :reject, params: {id: organization.id}).to redirect_to("/users/sign_in")
    end
  end

  describe "post reject with admin user" do
    let(:organization_approved_user) {create(:user, :organization_approved_user, :admin)}
    before(:each) {sign_in(organization_approved_user)}
    it "rejects and organization with approved user" do

      organization = create(:organization, status: :submitted)
      organization.reload

      expect(post :reject, params: { id: organization.id, organization: { rejection_reason: "You suck" } }).to redirect_to(organizations_path)
    end
  end

  describe "reject with admin users" do
    let(:organization_approved_user) {create(:user, :organization_approved_user, :admin)}
    before(:each) {sign_in(organization_approved_user)}
    it "approved user" do
      allow_any_instance_of(Organization).to receive(:save).and_return(false)
      organization = create(:organization, status: :submitted)
      organization.reload
      allow(Organization).to receive(:find).and_return(organization)
      expect(post :reject, params: { id: organization.id, organization: { rejection_reason: "You suck" } }).to redirect_to(organization_path(id: organization.id))
    end
  end

end
