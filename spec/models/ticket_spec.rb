require 'rails_helper'

RSpec.describe Ticket, type: :model do
  let(:category) { ResourceCategory.new }
  let(:region) { Region.new }
  let (:ticket) { Ticket.create(
    name: 'Foo',
    phone: '+15414541232',
    description: "Lorem ipsum",
    region_id: region.id,
    resource_category_id: category.id,
    closed: false
  )}


  it "exists" do
    Ticket.new
  end

  it "has a name" do
    expect(ticket).to respond_to(:name)
  end

  it "has a phone number" do
    expect(ticket).to respond_to(:phone)
  end

  it "has a description" do
    expect(ticket).to respond_to(:description)
  end

  it "references a region" do
    expect(ticket).to respond_to(:region_id)
  end

  it "references a resource category" do
    expect(ticket).to respond_to(:resource_category_id)
  end

end
