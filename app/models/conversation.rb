class Conversation < ApplicationRecord
  belongs_to :user
  belongs_to :site, optional: true

  has_many :messages, dependent: :destroy

  validates :title, presence: true
end
