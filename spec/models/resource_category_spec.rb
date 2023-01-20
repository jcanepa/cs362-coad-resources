require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  let (:resource_category) { ResourceCategory.new }

  # Test instanciation
  it "exists" do
    resource_category
  end

  it "has a name" do
    expect(resource_category).to respond_to(:name)
  end

  it "has an active status" do
    expect(resource_category).to respond_to(:active)
  end

  context 'associations' do
    it { should have_and_belong_to_many(:organizations).class_name('Organization') }
    it { should have_many(:tickets).class_name('Ticket') }
  end
end
