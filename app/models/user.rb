class User < ApplicationRecord

  enum role: [:admin, :organization]
  after_initialize :set_default_role, :if => :new_record?

  # Model associations
  belongs_to :organization, optional: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_presence_of :email
  validates_length_of :email, minimum: 1, maximum: 255, on: :create
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates_uniqueness_of :email, case_sensitive: false
  validates_presence_of :password, on: :create
  validates_length_of :password, minimum: 7, maximum: 255, on: :create

  def set_default_role
    self.role ||= :organization
  end

  def to_s
    email
  end

end
