class Issue < ApplicationRecord
  belongs_to :audit
  belongs_to :page, optional: true

  has_many :recommendations, dependent: :destroy

  validates :title, presence: true
  validates :category, inclusion: { in: %w[geo aeo seo tech content] }
  validates :severity, inclusion: { in: %w[critical high medium low] }
  validates :status, inclusion: { in: %w[open in_progress fixed ignored] }
end
