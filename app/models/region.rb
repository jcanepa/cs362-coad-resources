class Region < ApplicationRecord

  has_many :tickets

  validates_presence_of :name
  validates_length_of :name, minimum: 1, maximum: 255, on: :create
  validates_uniqueness_of :name, case_sensitive: false

  def self.unspecified
    Region.find_or_create_by(name: 'Unspecified')
  end

  def to_s
    name
  end

end
