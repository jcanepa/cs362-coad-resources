require 'rails_helper'

RSpec.describe Organization, type: :model do

    let(:organization) {
        Organization.new(
        name: "name",
        email: "name.@testing.com",
        phone: "541-398-3298",
        liability_insurance: true,
        primary_name: 'Primary Name',
        secondary_name: 'Secondary Name',
        secondary_phone: '555-555-5555',
        title: 'Title',
        transportation: :yes,
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore
                      et dolore magna aliqua. Quam adipiscing vitae proin sagittis nisl rhoncus. Nunc faucibus a pellentesque
                      sit amet porttitor eget dolor morbi. Eu non diam phasellus vestibulum lorem sed risus ultricies tristique.
                      Eu facilisis sed odio morbi quis commodo odio aenean sed. Aliquam purus sit amet luctus venenatis lectus magna.",
        status: 1
      )}

    # Test Instantiation
    it "exists" do 
        organization
    end

    # Test Attributtes
    it "has a name" do 
        org = organization
        expect(org).to respond_to(:name)
    end

    it "has an email" do
      expect(organization).to respond_to(:email)
    end

    it "has a phone number" do
      expect(organization).to respond_to(:phone)
    end

    it "has liability insurance" do
      expect(organization).to respond_to(:liability_insurance)
    end

    it "has a primary name" do
      expect(organization).to respond_to(:primary_name)
    end

    it "has a secondary name" do
      expect(organization).to respond_to(:secondary_name)
    end

    it "has a title" do
      expect(organization).to respond_to(:title)
    end

    it "has transportation set" do
      expect(organization).to respond_to(:transportation)
    end

    it "has a description" do
      expect(organization).to respond_to(:description)
    end

    it "has a string representation" do
        name = "name"
        org = organization
        expect(name).to eq(org.to_s)
    end

    it "has a status" do 
        org = organization
        expect(org).to respond_to(:status)
    end

    it "has transportation" do
        expect(organization).to respond_to(:transportation)
    end
    
    # Testing functions

    it "has set_default_status" do
        expect(organization).to respond_to(:set_default_status)
    end
    it "set status to approved" do
      expect(organization.approve).to eq(:approved)
    end

    it "set status to rejected" do
      expect(organization.reject).to eq(:rejected)
    end

    it "set default status" do
      expect(organization.set_default_status).to eq("submitted")
    end

    # Test associations

    context "association: has many users" do
        it { should have_many(:users).class_name('User') }
    end

    context "associations: has many tickets" do
      it { should have_many(:tickets).class_name('Ticket')}
    end

    context "associations: belongs to many resource categories" do
      it { should have_and_belong_to_many(:resource_categories).class_name("ResourceCategory")}
    end
    
    # Validators
    it "validates presence of name" do 
      expect(organization).to validate_presence_of(:name)
    end

    it "verifies the minimum length of name" do
      expect(organization).to validate_length_of(:name).is_at_least(1)
    end

    it "verfies the maximum length of name" do 
      expect(organization).to validate_length_of(:name).is_at_most(255)
    end

    it "validates presence of email" do 
      expect(organization).to validate_presence_of(:email)
    end

    it "verifies the minimum length of email" do 
      expect(organization).to validate_length_of(:email).is_at_least(1)
    end

    it "verifies the maximum length of an email" do
      expect(organization).to validate_length_of(:email).is_at_most(255)
    end

    it "verifies the uniqueness of an email" do 
      expect(organization).to validate_uniqueness_of(:email).ignoring_case_sensitivity
    end
end
