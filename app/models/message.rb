class Message < ApplicationRecord
  belongs_to :conversation

  validates :role, inclusion: { in: %w[user agent] }
  validates :content, presence: true
end
