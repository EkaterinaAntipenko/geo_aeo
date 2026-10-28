class Notification < ApplicationRecord
  self.inheritance_column = :_type_disabled

  TYPES = { "report" => "Отчёт", "alert" => "Сбой на сайте", "drop" => "Падение позиций" }

  belongs_to :user

  validates :type, inclusion: { in: TYPES.keys }
  validates :channel, inclusion: { in: %w[email telegram in_app] }

  def type_name
    TYPES[type]
  end

  def title
    payload["title"]
  end

  def site_domain
    payload["site"]
  end
end
