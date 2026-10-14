class AccountsController < ApplicationController
  def show
    @workspace = current_workspace
    @subscription = @workspace.subscriptions.last
  end
end
