class ApplicationController < ActionController::Base
  before_action :set_cookie_user

  def set_cookie_user
    if user_signed_in?
      cookies.encrypted[:user_id] = current_user.id
    else
      cookies.delete(:user_id)
    end
  end
end
