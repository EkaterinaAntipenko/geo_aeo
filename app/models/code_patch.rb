class CodePatch < ApplicationRecord
  belongs_to :recommendation

  validates :target, inclusion: { in: %w[html json-ld robots llms.txt meta] }
  validates :code, presence: true
end
