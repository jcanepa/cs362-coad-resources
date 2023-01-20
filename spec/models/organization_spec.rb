require 'rails_helper'

RSpec.describe Organization, type: :model do

    let(:organization) {
        Organization.create(
        name: "name",
        email: "#{"name".split(" ").join(".")}@testing.com",
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

    it "exists" do 
        Organization.new
    end

    it "has a name" do 
        org = organization
        expect(org).to respond_to(:name)
    end

    it "has a string representation  that is its name" do
        name = "name"
        org = organization
        expect(name).to eq(org.to_s)
    end

    it "has a status" do 
        org = organization
        expect(org).to respond_to(:status)
    end





end
