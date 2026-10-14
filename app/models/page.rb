class Page < ApplicationRecord
  belongs_to :site

  has_many :issues, dependent: :nullify

  validates :url, presence: true
  validates :title, presence: true
  validates :page_type, inclusion: { in: %w[home service product faq article] }
end
