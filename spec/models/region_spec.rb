require 'rails_helper'

RSpec.describe Region, type: :model do

  let(:region) {Region.create(name: "name")}
  let(:region_unspecified) {Region.unspecified}

  # Test instantiation

  it "exists" do
    region
  end

  # Test attributes

  it "has a name" do
    expect(region).to respond_to(:name)
  end

  # Testing functions
  it "has a string representation that is its name" do
    expect(region.to_s).to eq("name")
  end

  it "testing unspecified creation" do
    expect(region_unspecified.to_s).to eq("Unspecified")
  end

  it "validates presence of name" do
    expect(region).to validate_presence_of(:name)
  end

end
