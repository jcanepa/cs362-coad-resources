require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do

  #before(:each) {sign_in(organization_approved_user)}

  describe 'GET resources' do
    let(:organization_approved_user) { create(:user, :organization_approved_user)}
    let(:organization) {create(:organization)}
    before(:each) {sign_in(organization_approved_user)}
    it { expect(get(:index)).to be_successful } end

    #before(:example) {org = organization}
    let(:organization_approved_user) { create(:user, :organization_approved_user)}
    before(:each) {sign_in(organization_approved_user)}
    it 'updates an organization' do

      organization = create(:organization, name: 'Old name')

      organization.reload

      expect(put :update, params: { id: organization.id, organization: { name: "new_name", status: :approved } }).to redirect_to(organization_path(id: organization.id))
    end

    let(:organization_approved_user) { create(:user, :organization_approved_user)}
    before(:each) {sign_in(organization_approved_user)}
    it 'fails to update an organization' do

      organization = create(:organization, name: 'Old name', status: :approved)

      organization.reload

      expect(put :update, params: { id: organization.id, organization: { name: "", status: :rejected } }).to render_template(:edit)
    end

end
