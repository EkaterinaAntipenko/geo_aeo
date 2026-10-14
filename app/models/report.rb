class Report < ApplicationRecord
  belongs_to :site

  validates :period, inclusion: { in: %w[daily weekly monthly] }
  validates :summary, presence: true
end
