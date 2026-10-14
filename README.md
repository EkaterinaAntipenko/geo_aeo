# GEO/AEO сервис

Учебный проект на Ruby on Rails. Личный кабинет клиента сервиса, который проверяет сайты малого и среднего бизнеса и помогает им попадать в ответы ИИ-поисковиков (Яндекс Нейро, Алиса, AI Overviews, ChatGPT, Perplexity).

Что сделано для предпросмотра:

- схема модели и её реализация в коде (`db/migrate`, `db/schema.rb`, `app/models`)
- наполнение базы через сиды (`db/seeds.rb`)
- роутинг и навигация по страницам (`config/routes.rb`, `app/views/application/_menubar.html.erb`)
- вход в личный кабинет через Devise

## Стек

- Ruby 4.0.6
- Rails 8.1.4
- SQLite
- Devise

## Запуск

```shell
bundle install
rails db:migrate
rails db:seed
rails s
```

## Данные входа

- Почта: `test@email.com`
- Пароль: `test`
