class Audit < ApplicationRecord
  belongs_to :site

  has_many :issues, dependent: :destroy

  validates :kind, inclusion: { in: %w[geo aeo seo full] }
  validates :trigger, inclusion: { in: %w[scheduled manual onboarding] }
  validates :status, inclusion: { in: %w[queued running done failed] }
end
