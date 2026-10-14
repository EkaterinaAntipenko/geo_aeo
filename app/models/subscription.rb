class Subscription < ApplicationRecord
  belongs_to :workspace
  belongs_to :plan

  has_many :payments, dependent: :destroy

  validates :status, inclusion: { in: %w[trial active past_due canceled] }
end
