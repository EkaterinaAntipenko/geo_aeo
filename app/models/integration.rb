class Integration < ApplicationRecord
  belongs_to :site

  validates :provider, inclusion: { in: %w[webmaster gsc metrika github cms] }
  validates :status, inclusion: { in: %w[pending connected error] }
end
