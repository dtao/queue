class Task < ActiveRecord::Base
  belongs_to :user

  scope :pending, -> { where(:completed_at => nil).order(:updated_at => :asc) }
end
