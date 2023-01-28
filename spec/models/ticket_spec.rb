require 'rails_helper'

RSpec.describe Ticket, type: :model do

  # Dependency objects
  let(:category) { ResourceCategory.create(name: 'Test') }
  let(:region) { Region.create(name: 'Test') }
  let(:organization) { Organization.create(name: "@", email: "foo@test.com", phone: 5413983298, primary_name: '@', secondary_name: '@', secondary_phone: 5555555555) }

  # Model object
  let (:ticket) { Ticket.new(
    name: '',
    phone: '',
    description: '',
    region_id: region.id,
    resource_category_id: category.id)
  }

  # Persisted model object
  let (:db_ticket) { Ticket.create(
    name: '@',
    phone: 5101234567,
    description: '@',
    region_id: region.id,
    resource_category_id: category.id)
  }

  # Model instanciates
  it "exists" do
    Ticket.new
  end

  # Test attributes
  describe "attributes" do

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

    it "has a closed state" do
      expect(ticket).to respond_to(:closed)
    end

    it "defaults to false" do
      expect(ticket.closed).to be false
    end
  end

  # Test model associations (relationships)
  describe 'associations' do
    it { should belong_to(:region).class_name('Region') }
    it { should belong_to(:resource_category).class_name('ResourceCategory') }
    it { should belong_to(:organization).class_name('Organization').optional }
  end

  # Test model validation rules
  describe 'validation' do

    it "requires newly created model objects to conatin required validation logic" do
      expect(ticket.valid?).to be false
    end

    it "requires a valid name, description and phone" do
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
      ticket.phone = '@@@@@@@@@@'

      expect(ticket).to_not be_valid
    end

    it "rejects phone numbers that are too short" do
      ticket.name = '@'
      ticket.description = '@'
      ticket.phone = 0

      expect(ticket).to_not be_valid
    end

    it "rejects phone numbers that are too long" do
      ticket.name = '@'
      ticket.description = '@'
      ticket.phone = 510123456799

      expect(ticket).to_not be_valid
    end

    it "rejects phone numbers that are implausible" do
      ticket.name = '@'
      ticket.description = '@'
      ticket.phone = 0000000000

      expect(ticket).to_not be_valid
    end

    it "accepts phone numbers that are strings" do
      ticket.name = '@'
      ticket.description = '@'
      ticket.phone = '5101234567'

      expect(ticket).to be_valid
    end

    it "rejects phone numbers that include letters" do
      ticket.name = '@'
      ticket.description = '@'
      ticket.phone = '510123456r'

      expect(ticket).to_not be_valid
    end
  end

  # Test model methods (member functions)
  describe "methods" do

    it "responds to open?" do
      expect(ticket).to respond_to(:open?)
    end

    it "open? returns negated closed attribute" do
      expect(ticket.closed).to be false
      expect(ticket.open?).to be true
    end

    it "closing ticket changes boolean returned by open?" do
      ticket.closed = true
      expect(ticket.open?).to be false
    end

    it "responds to captured?" do
      expect(ticket).to respond_to(:captured?)
    end

    it "is captured? once an organization_id is assigned" do
        expect(ticket.captured?).to be false
        ticket.organization_id = organization.id
        expect(ticket.captured?).to be true
    end

    it "responds to to_s" do
      expect(ticket).to respond_to(:to_s)
    end

    it "'Ticket {id}' returned by to_s" do
      t = db_ticket

      expect(t.to_s).to eq("Ticket #{t.id}")
    end
  end

  describe "scopes" do

    describe ".open" do

      it "includes newly created tickets (tickets are open by default)" do
        expect(Ticket.open).to include(db_ticket)
      end

      it "includes open tickets with no orginization set" do
        db_ticket.update(closed: false)
        expect(Ticket.open).to include(db_ticket)
      end

      it "excludes open tickets with orginization set" do
        db_ticket.update(closed: false, organization_id: organization.id)
        expect(Ticket.open).to_not include(db_ticket)
      end

      it "excludes closed tickets with no orginization set" do
        db_ticket.update(closed: true)
        expect(Ticket.open).to_not include(db_ticket)
      end
    end

    describe ".closed" do

      it "includes closed tickets" do
        db_ticket.update(closed: true)
        expect(Ticket.closed).to include(db_ticket)
      end

      it "excludes opened tickets" do
        db_ticket.update(closed: false)
        expect(Ticket.closed).to_not include(db_ticket)
      end

    end

    describe ".all_organization" do

      it "includes open tickets with an organization set" do
        db_ticket.update(closed: false, organization_id: organization.id)
        expect(Ticket.all_organization).to include(db_ticket)
      end

      it "excludes open tickets with no organization set" do
        db_ticket.update(closed: false)
        expect(Ticket.all_organization).to_not include(db_ticket)
      end

      it "excludes closed tickets with an organization set" do
        db_ticket.update(closed: true, organization_id: organization.id)
        expect(Ticket.all_organization).to_not include(db_ticket)
      end

      it "excludes closed tickets with no organization set" do
        db_ticket.update(closed: true)
        expect(Ticket.all_organization).to_not include(db_ticket)
      end
    end

    describe ".organization" do

      it "includes open ticket with a given organization" do
        db_ticket.update(closed: false, organization_id: organization.id)
        expect(Ticket.organization(db_ticket.organization_id)).to include(db_ticket)
      end

      it "excludes closed ticket with a given organization" do
        db_ticket.update(closed: true, organization_id: organization.id)
        expect(Ticket.organization(db_ticket.organization_id)).to_not include(db_ticket)
      end

      it "excludes open ticket with unknown organization" do
        db_ticket.update(closed: false, organization_id: organization.id)
        expect(Ticket.organization(99)).to_not include(db_ticket)
      end

      it "excludes closed ticket with unknown organization" do
        db_ticket.update(closed: true, organization_id: organization.id)
        expect(Ticket.organization(99)).to_not include(db_ticket)
      end
    end

    describe ".closed_organization" do


    end

    describe ".region" do
    end

    describe ".resource_category" do
    end

  end
end
