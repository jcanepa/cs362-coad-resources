class Ticket < ApplicationRecord
  # Tickets are a request for free resources provided by member organizations. Tickets:
  # are created by a member of the public via form,
  # are associated with a geographic region,
  # are classified with a type of resource category
  # may be claimed by a non-profit organization
  # can be either open (unaddressed) or closed (request fulfilled).

  # Model associations
  belongs_to :region
  belongs_to :resource_category
  belongs_to :organization, optional: true

  # Validation
  validates_presence_of :name, :phone, :region_id, :resource_category_id
  validates_length_of :name, minimum: 1, maximum: 255, on: :create
  validates_length_of :description, maximum: 1020, on: :create
  validates :phone, phony_plausible: true

  # Custom queries return ActiveRecord::Relation
  scope :open, -> () { where closed: false, organization_id: nil }
  scope :closed, -> () { where closed: true }
  scope :all_organization, -> () { where(closed: false).where.not(organization_id: nil) }
  scope :organization, -> (organization_id) { where(organization_id: organization_id, closed: false) }
  scope :closed_organization, -> (organization_id) { where(organization_id: organization_id, closed: true) }
  scope :region, -> (region_id) { where(region_id: region_id) }
  scope :resource_category, -> (resource_category_id) { where(resource_category_id: resource_category_id) }

  def open?
    !closed
  end

  def captured?
    organization.present?
  end

  def to_s
    "Ticket #{id}"
  end

end
