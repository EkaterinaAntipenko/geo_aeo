class Task < ApplicationRecord
  STATUSES = { "todo" => "Запланировано", "doing" => "В работе", "done" => "Выполнено" }

  belongs_to :site
  belongs_to :recommendation, optional: true
  belongs_to :assignee, class_name: "User", optional: true
  belongs_to :creator, class_name: "User", foreign_key: :created_by

  validates :title, presence: true
  validates :status, inclusion: { in: STATUSES.keys }
  validates :priority, inclusion: { in: 1..3 }

  def next_status
    STATUSES.keys[STATUSES.keys.index(status) + 1]
  end
end
