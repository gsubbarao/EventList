class Event < ActiveRecord::Base
  
  attr_accessible :title, :description, :scheduled, :owner_id

  validates :title, :scheduled, :owner_id, :presence => true, :on => :create

  belongs_to :owner, :class_name => "User"
  has_and_belongs_to_many :users

end
