class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  layout :layout_by_resource

  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  helper_method :current_workspace, :current_site

  private

  def current_workspace
    @current_workspace ||= current_user.workspaces.first
  end

  def current_site
    return unless current_workspace

    @current_site ||= current_workspace.sites.find_by(id: session[:site_id]) || current_workspace.sites.order(:created_at).first
  end

  def render_not_found
    respond_to do |format|
      format.html { render "pages/not_found", status: :not_found }
      format.any { head :not_found }
    end
  end

  def after_sign_in_path_for(user)
    user.workspaces.any? ? root_path : new_onboarding_path
  end

  def layout_by_resource
    devise_controller? ? "auth" : "application"
  end
end
