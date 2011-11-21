class Trip < ActiveRecord::Base
  belongs_to :user

  validates :name, :presence => true
  validates :user, :presence => true

  attr_accessible :name, :places_attributes

  has_many :places, dependent: :destroy, :inverse_of => :trip

  accepts_nested_attributes_for :places, :reject_if => :all_blank

end
