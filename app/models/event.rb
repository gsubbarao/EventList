class Event < ActiveRecord::Base
	
	attr_accessible :title, :description, :scheduled

	belongs_to :user
	has_and_belongs_to_many :users

end
