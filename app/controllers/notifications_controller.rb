class NotificationsController < ApplicationController
  def index
    if user_signed_in?
      notifications = Notification.for(current_user).select(:id, :content, :is_read, :created_at).limit(30)
    else
      render json: { message: "ログインが必要です" }, status: 400 and return
    end
    render json: notifications.map{|m| {
      id: m.id,
      content: m.content,
      is_read: m.is_read,
      created_at: m.created_at.in_time_zone(user_signed_in? ? current_user.time_zone : I18n.locale == :en ? "UTC" : "Asia/Tokyo").strftime("%Y-%m-%d %H:%M:%S")
    }}.to_json
  end

  def create
    if user_signed_in?
      Notification.to(current_user, "sent notification")
    else
      render json: { message: "ログインが必要です" }, status: 400 and return
    end
    render json: {
      message: "send"
    }, status: 200
  end

  def destroy
    if user_signed_in?
      notification = Notification.find_by(id: params[:id], user: current_user)
    end
    if notification.destroy
      render json: {
        message: "Deleted"
      }, status: 200
    else
      render json: {
        message: notification.errors.full_messages.join('<br>').html_safe
      }, status: 400
    end
  end

  def update
    if user_signed_in?
      notification = Notification.find_by(id: params[:id], user: current_user)
    end
    unless notification
      render json: { message: "不正なパラメーターです" }, status: 400 and return
    end

    if params[:is_read] && params[:is_read] == true
      notification.is_read = true
    else
      notification.is_read = false
    end
    if notification.save
      render json: {
        message: "Updated"
      }, status: 200
    else
      render json: {
        message: notification.errors.full_messages.join('<br>').html_safe
      }, status: 400
    end
  end

  def read
    if user_signed_in?
      notifications = Notification.where(id: params[:ids], user: current_user).update_all(is_read: true)
    else
      render json: { message: "ログインが必要です" }, status: 400 and return
    end
    render json: {
      message: "Updated"
    }, status: 200
  end

  private
  def notifications_params
    params.require(:notifications).permit(:is_read)
  end
end
