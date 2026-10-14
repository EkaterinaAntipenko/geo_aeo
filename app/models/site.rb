class Site < ApplicationRecord
  belongs_to :workspace

  has_many :integrations, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :pages, dependent: :destroy
  has_many :audits, dependent: :destroy
  has_many :issues, through: :audits
  has_many :health_checks, dependent: :destroy
  has_many :queries, dependent: :destroy
  has_many :competitors, dependent: :destroy
  has_many :conversations, dependent: :nullify

  validates :domain, presence: true, uniqueness: true
  validates :cms, inclusion: { in: %w[tilda wordpress bitrix custom] }
  validates :site_type, inclusion: { in: %w[landing multipage] }
end
