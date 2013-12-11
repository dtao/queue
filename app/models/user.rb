class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of   :name
  validates_presence_of   :email
  validates_uniqueness_of :email

  strip_attributes :except => [:password, :password_confirmation]
end
