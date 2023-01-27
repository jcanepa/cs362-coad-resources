require 'rails_helper'

RSpec.describe Ticket, type: :model do

  # Dependency objects creation
  let(:category) { ResourceCategory.create(name: 'Test') }
  let(:region) { Region.create(name: 'Test') }
  # Model object
  let (:ticket) { Ticket.new(
    name: '',
    phone: '',
    description: '',
    region_id: region.id,
    resource_category_id: category.id)
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
  describe 'validation' do

    it "requires model validation logic" do
      expect(ticket.valid?).to be false
    end

    it "requires a name, description and phone" do
      ticket.name = '@'
      ticket.description = '@'
      ticket.phone = 5101234567

      expect(ticket.valid?).to be true
    end

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

    it {
      should validate_length_of(:description)
      .is_at_most(1020)
      .on(:create)
    }

    it "rejects invalid phone characters" do
      ticket.name = '@'; ticket.description = '@'
      ticket.phone = '@'

      expect(ticket.invalid?).to be true
      expect(ticket).to_not be_valid
    end

    it "rejects invalid phone characters" do
    end

    it "rejects invalid phone lengths" do
    end

  end
end
