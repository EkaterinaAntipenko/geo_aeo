class Message < ApplicationRecord
  DEFAULT_ANSWER = <<~TEXT
    Чтобы улучшить позиции страницы в поиске Яндекса, сделайте так:

    Проведите аудит - проверьте страницу в Яндекс Вебмастере и Метрике (ошибки, отказы, время на странице).

    Настройте технику - ускорьте загрузку, адаптируйте под мобильные, включите HTTPS, добавьте микроразметку.
    Улучшите контент - сделайте его полезным и структурированным, органично впишите ключи, регулярно обновляйте.

    Работайте с поведением пользователей - добавьте мультимедиа, понятные кнопки и ответы на частые вопросы.
  TEXT

  belongs_to :conversation

  validates :role, inclusion: { in: %w[user agent] }
  validates :content, presence: true

  def self.answer_for(question)
    words = question.downcase.scan(/[а-яёa-z]{4,}/)
    article = Article.all.find do |a|
      text = "#{a.title} #{a.lead}".downcase
      words.any? { |word| text.include?(word[0, 5]) }
    end

    if article
      [ "#{article.lead}.\n\nПодробно разобрали это в совете «#{article.title}». Если хотите, добавлю задачу в план работ.", "article:#{article.id}" ]
    else
      [ DEFAULT_ANSWER, nil ]
    end
  end

  def title
    article ? article.title : "Улучшение показателей поиска"
  end

  def article
    return unless context_ref.to_s.start_with?("article:")

    Article.find_by(id: context_ref.delete_prefix("article:"))
  end
end
