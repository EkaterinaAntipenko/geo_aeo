class SitesController < ApplicationController
  def select
    site = current_workspace.sites.find(params[:id])
    session[:site_id] = site.id
    redirect_back fallback_location: root_path
  end
end
