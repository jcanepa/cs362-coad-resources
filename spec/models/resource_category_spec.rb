require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  let (:resource_category) { ResourceCategory.new(
    name: 'name') 
  }

  let (:resource_category_unspecified) { ResourceCategory.unspecified }

  let (:db_resource_category) { ResourceCategory.create(
    name: 'db_name')
  }

  # Test instanciation

  it "exists" do
    resource_category
  end

  # Test attributes

  it "has a name" do
    expect(resource_category).to respond_to(:name)
  end

  it "has an active status" do
    expect(resource_category).to respond_to(:active)
  end

  # Test associations
  context 'associations' do
    it { should have_and_belong_to_many(:organizations).class_name('Organization') }
    it { should have_many(:tickets).class_name('Ticket') }
  end

  # Test functions

  it "validates unspecified static method" do
    expect(ResourceCategory.unspecified.name)
    .to eq('Unspecified')
  end

  it "can deactivate status" do
    resource_category.deactivate
    expect(resource_category.active)
    .to eq(false)
  end

  it "can activate status" do
    resource_category.activate
    expect(resource_category.active)
    .to eq(true)
  end

  it "tells when status is active" do
    expect(resource_category.inactive?)
    .to eq(false)
  end

  it "tells when status in inactive" do
    resource_category.deactivate
    expect(resource_category.inactive?)
    .to eq(true)
  end

  it "can print name" do
    expect(resource_category.to_s)
    .to eq("name")
  end

  # Test validators

  it "has a name" do
    expect(resource_category)
    .to validate_presence_of(:name)
  end

  it "has a unique name" do
    expect(resource_category)
    .to validate_uniqueness_of(:name)
    .ignoring_case_sensitivity
  end

  it "verifies minimum length of name" do
    expect(resource_category)
    .to validate_length_of(:name)
    .is_at_least(1)
  end

  it "verifies maximum length of name" do
    expect(resource_category)
    .to validate_length_of(:name)
    .is_at_most(255)
  end

  # Test scopes

  it ".active includes newly created resource categories (active by default)" do
    expect(ResourceCategory.active)
    .to include(db_resource_category)
  end

  it ".active excludes inactive resource categories" do
    db_resource_category.update(active: false)
    expect(ResourceCategory.active)
    .to_not include(db_resource_category)
  end

  it ".inactive includes inactive resource categories" do
    db_resource_category.update(active: false)
    expect(ResourceCategory.inactive)
    .to include(db_resource_category)
  end

  it ".inactive excludes active resource categories" do
    expect(ResourceCategory.inactive)
    .to_not include(db_resource_category)
  end

end
