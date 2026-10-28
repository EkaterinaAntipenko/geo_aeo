class Site < ApplicationRecord
  PAGES_PLANS = [ "1 - 5", "5 - 20", "20 - 100", "100 - 500", "500 +" ]

  belongs_to :workspace

  has_many :integrations, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :pages, dependent: :destroy
  has_many :audits, dependent: :destroy
  has_many :issues, through: :audits
  has_many :health_checks, dependent: :destroy
  has_many :queries, dependent: :destroy
  has_many :competitors, dependent: :destroy
  has_many :conversations, dependent: :nullify
  has_many :tasks, dependent: :destroy

  validates :domain, presence: true, uniqueness: true
  validates :cms, inclusion: { in: %w[tilda wordpress bitrix custom] }, allow_nil: true
  validates :site_type, inclusion: { in: %w[landing multipage] }
  validates :pages_plan, inclusion: { in: PAGES_PLANS }, allow_nil: true

  def score
    values = [ geo_score, aeo_score, seo_score ].compact
    return if values.empty?

    (values.sum / values.size / 10).round(1)
  end

  def score_text
    if score.nil?
      "Первая проверка уже в очереди, результат появится здесь"
    elsif score >= 8
      "Очень хорошо! Но есть пару моментов. Подробнее в аудите"
    elsif score >= 5
      "Неплохо, но есть что улучшить. Подробнее в аудите"
    else
      "Сайту нужна помощь. Начните с задач из аудита"
    end
  end

  def mentions_by_month(months)
    from = (months - 1).months.ago.beginning_of_month.to_date
    snapshots = PositionSnapshot.joins(:query)
      .where(queries: { site_id: id }, competitor_id: nil, is_mentioned: true)
      .where(checked_at: from..Date.current)

    counts = snapshots.group_by { |snapshot| snapshot.checked_at.beginning_of_month }.transform_values(&:count)

    (0...months).map do |i|
      month = from >> i
      [ month, counts.fetch(month, 0) ]
    end
  end
end
