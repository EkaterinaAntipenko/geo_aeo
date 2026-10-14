class HealthCheck < ApplicationRecord
  belongs_to :site

  validates :checked_at, presence: true
  validates :http_status, presence: true
end
