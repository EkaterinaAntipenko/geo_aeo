class AIEngine < ApplicationRecord
  self.inheritance_column = :_type_disabled

  has_many :position_snapshots, foreign_key: :engine_id, dependent: :destroy

  validates :name, inclusion: { in: [ "Яндекс Нейро", "Алиса", "AI Overviews", "ChatGPT", "Perplexity" ] }
  validates :type, inclusion: { in: %w[ai_search llm classic] }
end
