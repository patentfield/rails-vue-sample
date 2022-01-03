class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    if current_user && current_user.is_a?(User)
      stream_for "user_#{current_user.id}"
    end
  end
end
