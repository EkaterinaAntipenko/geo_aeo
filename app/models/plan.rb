class Plan < ApplicationRecord
  has_many :subscriptions, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :site_type, inclusion: { in: %w[landing multipage] }
  validates :price_month, presence: true
end
