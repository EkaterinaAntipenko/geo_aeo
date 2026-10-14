class IssuesController < ApplicationController
  def show
    @audit = current_workspace.audits.find(params[:audit_id])
    @issue = @audit.issues.find(params[:id])
  end
end
