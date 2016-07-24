class Venue < ActiveRecord::Base
  belongs_to :region
  belongs_to :user
  
  validates_uniqueness_of :name
end
