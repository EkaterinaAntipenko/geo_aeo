class Notification < ApplicationRecord
  self.inheritance_column = :_type_disabled

  belongs_to :user

  validates :type, inclusion: { in: %w[report alert drop] }
  validates :channel, inclusion: { in: %w[email telegram in_app] }
end
