class NotificationsController < ApplicationController
  def read_all
    current_user.notifications.where(is_read: false).update_all(is_read: true)
    redirect_back fallback_location: root_path, status: :see_other
  end
end
