class Place < ActiveRecord::Base
  belongs_to :trip

  validates :name, :trip, presence: true

  attr_accessible :name
end
