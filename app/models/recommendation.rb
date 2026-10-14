class Recommendation < ApplicationRecord
  belongs_to :issue

  has_many :code_patches, dependent: :destroy
  has_many :tasks, dependent: :destroy

  validates :title, presence: true
  validates :explanation, presence: true
  validates :expected_impact, inclusion: { in: %w[high mid low] }
  validates :effort, inclusion: { in: %w[S M L] }
  validates :status, inclusion: { in: %w[proposed accepted done rejected] }
end
