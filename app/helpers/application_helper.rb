module ApplicationHelper
  
  def can_attend?(at)
    user_siginin? && (DateTime.now < at)
  end

  def attentd_status(event)
    current_user.events.include?(event) ? "Unattend" : "Attend"
  end
end
