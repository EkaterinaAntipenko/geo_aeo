class Article < ApplicationRecord
  IMAGES = {
    "Глаз" => "okula/tip-eye.png",
    "Облачко" => "okula/tip-faq.png",
    "Кавычки" => "okula/tip-quotes.png",
    "Чип" => "okula/tip-chip.png",
    "Звенья" => "okula/tip-link.png",
    "График" => "okula/tip-chart.png"
  }

  belongs_to :category

  validates :title, presence: true
  validates :body, presence: true
  validates :image, inclusion: { in: IMAGES.values }
  validates :read_time, numericality: { greater_than: 0 }

  def self.search(text)
    return all if text.blank?

    where("title LIKE :q OR lead LIKE :q", q: "%#{sanitize_sql_like(text)}%")
  end

  def headings
    body.lines.grep(/\A## /).map { |line| line.delete_prefix("## ").strip }
  end
end
