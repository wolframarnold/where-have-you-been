class Trip < ActiveRecord::Base
  belongs_to :user

  validates :name, :presence => true
  validates :user, :presence => true
  validates :begun_on, :presence => true, :if => Proc.new {|trip| trip.ended_on.present?}
  validates :ended_on, :presence => true, :if => Proc.new {|trip| trip.begun_on.present?}

  attr_accessible :name, :places_attributes, :begun_on, :ended_on

  has_many :places, dependent: :destroy, :inverse_of => :trip

  accepts_nested_attributes_for :places, :reject_if => :all_blank

  scope :desc, order('created_at DESC')

  def as_json(opts={})
    super(opts.merge(:include => :places))
  end

end
