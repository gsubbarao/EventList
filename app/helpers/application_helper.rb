module ApplicationHelper
	
	def can_attend?(at)
		user_siginin? && (DateTime.now < at)
	end

end
