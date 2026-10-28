class Conversation < ApplicationRecord
  belongs_to :user
  belongs_to :site, optional: true

  has_many :messages, dependent: :destroy

  validates :title, presence: true

  def ask(question)
    messages.create!(role: "user", content: question)

    answer, context = Message.answer_for(question)
    messages.create!(role: "agent", content: answer, context_ref: context)
  end
end
