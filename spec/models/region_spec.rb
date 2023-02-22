require 'rails_helper'

RSpec.describe Region, type: :model do

  let(:region) { create(:region) }
  let(:unspecified_region) { Region.unspecified }

  it "exists" do
    region
  end

  describe "attributes" do
    it "has a name" do
      expect(region).to respond_to(:name)
    end
  end

  describe "associations" do
    it { should have_many(:tickets).class_name('Ticket') }
  end

  describe "methods" do

    it "statically creates an unspecified instance" do
      unspecified_region
    end

    it "has a string representation of its name" do
      expect(region.to_s)
        .to eq("foo")
    end

    it "aptly names an unspecified instance" do
      expect(unspecified_region.to_s)
        .to eq("Unspecified")
    end
  end

  describe 'validation' do

    it "validates presence of name" do
      expect(region)
        .to validate_presence_of(:name)
    end

    it "validates the minimum length of name" do
      expect(region).to validate_length_of(:name)
        .is_at_least(1)
        .on(:create)
    end

    it "validates the maximum length of name" do
      expect(region)
        .to validate_length_of(:name)
        .is_at_most(255)
        .on(:create)
    end

    it "validates the uniqueness of a name" do
      expect(region)
        .to validate_uniqueness_of(:name)
        .ignoring_case_sensitivity
    end

    it "validates unspecified static method" do
      expect(unspecified_region.name)
        .to eq("Unspecified")
    end
  end

end
