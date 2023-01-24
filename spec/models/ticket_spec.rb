require 'rails_helper'

RSpec.describe Ticket, type: :model do

  # Dependency objects creation
  let(:category) { ResourceCategory.new }
  let(:region) { Region.new }

  let (:ticket) { Ticket.new(
    name: 'Foo',
    phone: '+1234567890',
    description: "Lorem ipsum",
    region_id: region.id,
    resource_category_id: category.id,
    closed: false)
  }

  # Test instanciation
  it "exists" do
    Ticket.new
  end

  # Test attributes
  it "has a name" do
    expect(ticket).to respond_to(:name)
  end

  it "has a phone number" do
    expect(ticket).to respond_to(:phone)
  end

  it "has a description" do
    expect(ticket).to respond_to(:description)
  end

  # Foreign key attributes
  it "references a region" do
    expect(ticket).to respond_to(:region_id)
  end

  it "references a resource category" do
    expect(ticket).to respond_to(:resource_category_id)
  end

  it "has a closed state" do
    expect(ticket).to respond_to(:closed)
  end

  # Test model associations (relationships)
  describe 'associations' do
    it { should belong_to(:region).class_name('Region') }
    it { should belong_to(:resource_category).class_name('ResourceCategory') }
    it { should belong_to(:organization).class_name('Organization').optional }
  end

  # Test model validators
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:region_id) }
    it { should validate_presence_of(:resource_category_id) }

    it {
      should validate_length_of(:name)
      .is_at_least(1)
      .is_at_most(255)
      .on(:create)
    }
  end
end
