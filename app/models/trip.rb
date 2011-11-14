class Trip < ActiveRecord::Base
  belongs_to :user

  validates :name, :presence => true
  validates :user, :presence => true

  attr_accessible :name

  has_many :places, dependent: :destroy

end
