class DashboardController < ApplicationController
  def index
    @sites = current_workspace.sites.order(:domain)
    @audits = current_workspace.audits.order(started_at: :desc).limit(5)
    @tasks = current_workspace.tasks.where.not(status: "done")
    @notifications = current_user.notifications.order(created_at: :desc).limit(5)
  end
end
