class Task < ApplicationRecord
  belongs_to :recommendation
  belongs_to :assignee, class_name: "User", optional: true
  belongs_to :creator, class_name: "User", foreign_key: :created_by

  validates :status, inclusion: { in: %w[todo doing review done] }
end
