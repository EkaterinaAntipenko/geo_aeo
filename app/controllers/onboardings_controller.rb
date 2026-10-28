class OnboardingsController < ApplicationController
  layout "auth"

  def new
    @site = Site.new(pages_plan: Site::PAGES_PLANS.first)
  end

  def create
    @site = Site.new(site_params)
    @site.domain = @site.domain.to_s.strip.sub(%r{\Ahttps?://}, "").sub(%r{/.*\z}, "").downcase
    @site.site_type = @site.pages_plan == Site::PAGES_PLANS.first ? "landing" : "multipage"
    @site.workspace = current_workspace || build_workspace

    if params[:role].blank? || params[:industry].blank?
      @site.errors.add(:base, "Выберите роль и расскажите, чем занимается компания")
      return render :new, status: :unprocessable_entity
    end

    if @site.save
      current_user.update(role: params[:role])
      @site.audits.create!(kind: "full", trigger: "onboarding", status: "queued", started_at: Time.current)
      session[:site_id] = @site.id
      redirect_to root_path, notice: "Сайт #{@site.domain} подключён, первая проверка уже в очереди"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def site_params
    params.require(:site).permit(:domain, :brand_name, :pages_plan)
  end

  def build_workspace
    workspace = Workspace.new(name: site_params[:brand_name].presence || current_user.name, industry: params[:industry], owner: current_user)
    workspace.memberships.build(user: current_user, role: params[:role].presence || "owner", joined_at: Time.current)
    workspace.subscriptions.build(plan: Plan.order(:price_month).first, status: "trial", started_at: Time.current, trial_ends_at: 14.days.from_now.to_date)
    workspace
  end
end
