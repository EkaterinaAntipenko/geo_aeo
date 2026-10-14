class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :workspace
  belongs_to :inviter, class_name: "User", foreign_key: :invited_by, optional: true

  validates :role, inclusion: { in: %w[owner admin marketer developer] }
end
