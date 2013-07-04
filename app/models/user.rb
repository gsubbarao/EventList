class User < ActiveRecord::Base
  
  attr_accessible :name, :gender, :email, :password, :password_confirmation
  
  has_secure_password

  validates_presence_of :password, :on => :create

  has_many :own_events, :foreign_key => :id

  has_and_belongs_to_many :events
  
end
