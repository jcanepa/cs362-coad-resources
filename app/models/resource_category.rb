class ResourceCategory < ApplicationRecord
  # Resource categories classify the types of resources an organization offers.
  # Category parity of Organizations and Tickets enforce which submitted tickets organizations can claim.

  # Model associations
  has_and_belongs_to_many :organizations
  has_many :tickets

  validates_presence_of :name
  validates_length_of :name, minimum: 1, maximum: 255, on: :create
  validates_uniqueness_of :name, case_sensitive: false

  scope :active, -> () { where active: true }
  scope :inactive, -> () { where active: false }

  def self.unspecified
    ResourceCategory.find_or_create_by(name: 'Unspecified')
  end

  def activate
    self.update(active: true)
  end

  def deactivate
    self.update(active: false)
  end

  def inactive?
    !active?
  end

  def to_s
    name
  end

end
