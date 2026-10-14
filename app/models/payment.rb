class Payment < ApplicationRecord
  belongs_to :subscription

  validates :amount, presence: true
  validates :status, inclusion: { in: %w[pending succeeded failed refunded] }
end
