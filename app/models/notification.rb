class Notification < ApplicationRecord
  belongs_to :user, optional: true

  validates :content, presence: true, length: {maximum: 4096}

  scope :for, ->(obj) {
    if obj.is_a?(User)
      query = "notifications.user_id = #{obj.id}"
    end
    where(query)
    .order(created_at: :desc)
  }

  def self.to obj, message
    if obj.is_a?(User)
      channel = "user_#{obj.id}"
      notification = Notification.create(user: obj, content: message)
    end
    NotificationsChannel.broadcast_to(channel,
      id: notification.id,
      content: message,
      is_read: notification.is_read,
      created_at: notification.created_at.in_time_zone("Asia/Tokyo").strftime("%Y-%m-%d %H:%M:%S")
    )
  end
end
