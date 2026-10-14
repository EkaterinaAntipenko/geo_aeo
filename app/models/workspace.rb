class Workspace < ApplicationRecord
  belongs_to :owner, class_name: "User"

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :subscriptions, dependent: :destroy
  has_many :sites, dependent: :destroy
  has_many :audits, through: :sites
  has_many :issues, through: :audits
  has_many :recommendations, through: :issues
  has_many :tasks, through: :recommendations
  has_many :queries, through: :sites

  validates :name, presence: true
  validates :industry, presence: true
  validates :region, presence: true
end
