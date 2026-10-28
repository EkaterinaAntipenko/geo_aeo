class DashboardController < ApplicationController
  PERIODS = { "year" => 12, "half" => 6, "quarter" => 3 }

  def index
    @period = PERIODS.key?(params[:period]) ? params[:period] : "year"
    @articles = Article.order(:created_at).limit(6)

    if current_site
      @mentions = current_site.mentions_by_month(PERIODS[@period])
      @queries = current_site.queries.where(is_tracked: true).sort_by { |query| query.current_position || 100 }.first(4)
    else
      @mentions = []
      @queries = []
    end
  end
end
