class User < ActiveRecord::Base

  attr_accessible :name, :gender, :email, :password, :password_confirmation

  has_secure_password

  validates :name, :email, :password, :presence => true, :on => :create

  GENDER = { :MALE => 1, :FEMALE => 0 }

  has_many :own_events, :foreign_key => :owner_id, :class_name => "Event"

  has_and_belongs_to_many :events

end
