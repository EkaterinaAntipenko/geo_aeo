class SitesController < ApplicationController
  def index
    @sites = current_workspace.sites.order(:domain)
  end

  def show
    @site = current_workspace.sites.find(params[:id])
    @health_checks = @site.health_checks.order(checked_at: :desc).limit(7)
  end
end
