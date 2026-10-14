class Query < ApplicationRecord
  belongs_to :site

  has_many :position_snapshots, dependent: :destroy

  validates :text, presence: true
  validates :intent, inclusion: { in: %w[info commercial local] }
end
