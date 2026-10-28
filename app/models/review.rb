class Review < ApplicationRecord
  validates :company, presence: true
  validates :author, presence: true
  validates :text, presence: true
end
