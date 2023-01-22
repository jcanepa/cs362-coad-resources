require 'rails_helper'

RSpec.describe Region, type: :model do

  let(:region) {Region.create(name: "name")}


  it "exists" do
    region
  end

  it "has a name" do
    expect(region).to respond_to(:name)
  end

  it "has a string representation that is its name" do
    expect(region.to_s).to eq("name")
  end

end
