class User < ActiveRecord::Base
  has_secure_password :validations => false

  has_many :identities

  validates_presence_of   :name
  validates_uniqueness_of :email, :if => :has_email?
  validates               :email, :email => true, :if => :has_email?

  strip_attributes :except => [:password, :password_confirmation]

  def has_email?
    self.email.present?
  end
end
