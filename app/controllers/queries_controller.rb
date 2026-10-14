class QueriesController < ApplicationController
  def show
    @query = current_workspace.queries.find(params[:id])
    @position_snapshots = @query.position_snapshots.order(checked_at: :desc)
  end
end
