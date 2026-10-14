class Competitor < ApplicationRecord
  belongs_to :site
  belongs_to :author, class_name: "User", foreign_key: :added_by

  has_many :position_snapshots, dependent: :nullify

  validates :domain, presence: true
  validates :name, presence: true
end
