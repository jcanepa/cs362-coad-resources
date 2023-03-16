require 'rails_helper'

RSpec.describe DashboardController, type: :controller do

  it 'exists' do
    Class.new { include Dashboard }
  end

  # describe "GET #index while logged in" do
  #   let(:user) { create(:user) }

  #   it { expect(get(:index)).to_be_successful }
  # end

  # describe "GET #index while logged out" do
  #   it {expect(get(:index)).to redirect_to(new_user_session_path)}
  # end

  describe "approved logged in user" do
    let(:approved_user) { create(:user, :organization_approved_user)}
    before(:each) { sign_in(approved_user)}

    it "checks index" do
      expect(get(:index)).to be_successful
    end
  end

  describe "logged in admin user" do
    let(:approved_admin_user) { create(:user, :organization_approved_user, :admin)}
    before(:each) { sign_in(approved_admin_user)}
    it { expect(get(:index)).to be_successful}
  end

  describe "not logged in user" do
    it{expect(get(:index)).to redirect_to("/users/sign_in")}
  end

  describe "no organization user" do
    let(:no_organization_user) {create(:user)}
    before(:each) { sign_in(no_organization_user)}

    it { expect(get(:index)).to be_successful}
  end
end
