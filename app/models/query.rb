class Query < ApplicationRecord
  belongs_to :site

  has_many :position_snapshots, dependent: :destroy

  validates :text, presence: true
  validates :intent, inclusion: { in: %w[info commercial local] }

  def average_position(from, to)
    position_snapshots.where(competitor_id: nil, checked_at: from..to).where.not(position: nil).average(:position)
  end

  def current_position
    average_position(30.days.ago.to_date, Date.current)
  end

  def trend
    now = current_position
    before = average_position(60.days.ago.to_date, 31.days.ago.to_date)
    return if now.nil? || before.nil? || now == before

    now < before ? "up" : "down"
  end
end
