class PositionSnapshot < ApplicationRecord
  belongs_to :query
  belongs_to :engine, class_name: "AIEngine"
  belongs_to :competitor, optional: true

  validates :checked_at, presence: true
end
