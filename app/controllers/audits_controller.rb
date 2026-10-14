class AuditsController < ApplicationController
  def index
    @audits = current_workspace.audits.order(started_at: :desc)
  end

  def show
    @audit = current_workspace.audits.find(params[:id])
  end
end
