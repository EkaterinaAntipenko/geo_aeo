class AccountsController < ApplicationController
  def show
    @subscription = current_workspace&.subscriptions&.order(:started_at)&.last
    @sites = current_workspace ? current_workspace.sites.order(:created_at) : []
    @requests_count = Message.joins(:conversation)
      .where(role: "user", created_at: Time.current.beginning_of_month.., conversations: { user_id: current_user.id })
      .count
  end

  def check_connection
    return redirect_to new_onboarding_path, alert: "Сначала подключите сайт" unless current_site

    current_site.update(verified: true)
    redirect_to account_path, notice: "Код найден на #{current_site.domain}, сайт подключён"
  end
end
