# Очищаем старые данные

Message.destroy_all
Conversation.destroy_all
PositionSnapshot.destroy_all
Competitor.destroy_all
Query.destroy_all
Task.destroy_all
CodePatch.destroy_all
Recommendation.destroy_all
Issue.destroy_all
Audit.destroy_all
HealthCheck.destroy_all
Page.destroy_all
Report.destroy_all
Integration.destroy_all
Site.destroy_all
Payment.destroy_all
Subscription.destroy_all
Plan.destroy_all
Notification.destroy_all
Membership.destroy_all
Workspace.destroy_all
AIEngine.destroy_all
User.destroy_all
Article.destroy_all
Category.destroy_all
Review.destroy_all

puts "All data just destroyed"




# ИИ-движки

yandex_neuro = AIEngine.create!(name: "Яндекс Нейро", type: "ai_search", region: "Россия", is_active: true)
alice = AIEngine.create!(name: "Алиса", type: "llm", region: "Россия", is_active: true)
ai_overviews = AIEngine.create!(name: "AI Overviews", type: "ai_search", region: "Глобально", is_active: true)
chatgpt = AIEngine.create!(name: "ChatGPT", type: "llm", region: "Глобально", is_active: true)
perplexity = AIEngine.create!(name: "Perplexity", type: "ai_search", region: "Глобально", is_active: true)

engines = [ yandex_neuro, alice, ai_overviews, chatgpt, perplexity ]

puts "ИИ-движки созданы: #{AIEngine.count}"




# Тарифы

start = Plan.create!(
  name: "Старт",
  site_type: "landing",
  price_month: 1990,
  pages_limit: 20,
  domains_limit: 3,
  queries_limit: 100,
  features: [ "Проверка лендингов раз в сутки", "Отчёт на почту", "5 ИИ-движков" ]
)

growth = Plan.create!(
  name: "Рост",
  site_type: "multipage",
  price_month: 5990,
  pages_limit: 200,
  domains_limit: 10,
  queries_limit: 500,
  features: [ "Проверка каждый час", "Готовые правки кода", "ИИ-помощник", "Уведомления в Telegram" ]
)

agency = Plan.create!(
  name: "Агентство",
  site_type: "multipage",
  price_month: 14990,
  pages_limit: 1000,
  domains_limit: 50,
  queries_limit: 2000,
  features: [ "Всё из тарифа «Рост»", "Мониторинг конкурентов", "API", "Отчёты для клиентов" ]
)

puts "Тарифы созданы: #{Plan.count}"




# Пользователи

ekaterina = User.create!(name: "Антипенко Екатерина", email: "test@email.com", role: "developer", phone: "+7 (916) 555-12-34", avatar: "okula/avatar.png", admin: true, password: "test")
dzhabbar = User.create!(name: "Джаббар Гулиев", email: "dzhabbar@example.com", role: "developer", password: "test")
anna = User.create!(name: "Анна Смирнова", email: "anna@example.com", role: "owner", telegram_id: "@anna_zerno", password: "test")
igor = User.create!(name: "Игорь Волков", email: "igor@example.com", role: "owner", password: "test")
dmitry = User.create!(name: "Дмитрий Орлов", email: "dmitry@example.com", role: "owner", telegram_id: "@dmitry_kvadrat", password: "test")
olga = User.create!(name: "Ольга Морозова", email: "olga@example.com", role: "marketer", password: "test")
pavel = User.create!(name: "Павел Соколов", email: "pavel@example.com", role: "developer", telegram_id: "@pavel_dev", password: "test")

puts "Пользователи созданы: #{User.count}"




# Клиенты

mirk = Workspace.create!(name: "МИРК", legal_name: "АНО ДПО «МИРК»", industry: "Дополнительное профессиональное образование", region: "Москва", owner: ekaterina)
zerno = Workspace.create!(name: "Кофейня «Зерно»", legal_name: "ООО «Зерно»", industry: "Общепит", region: "Москва", owner: anna)
ulybka = Workspace.create!(name: "Стоматология «Улыбка»", legal_name: "ООО «Клиника Улыбка»", industry: "Медицина", region: "Казань", owner: igor)
kvadrat = Workspace.create!(name: "Ремонт «Квадрат»", legal_name: "ИП Орлов Д. А.", industry: "Ремонт и строительство", region: "Санкт-Петербург", owner: dmitry)

puts "Клиенты созданы: #{Workspace.count}"




# Участники команд

memberships = [
  { user: ekaterina, workspace: mirk, role: "owner" },
  { user: dzhabbar, workspace: mirk, role: "developer", inviter: ekaterina },
  { user: anna, workspace: zerno, role: "owner" },
  { user: pavel, workspace: zerno, role: "developer", inviter: anna },
  { user: igor, workspace: ulybka, role: "owner" },
  { user: olga, workspace: ulybka, role: "marketer", inviter: igor },
  { user: dmitry, workspace: kvadrat, role: "owner" },
  { user: pavel, workspace: kvadrat, role: "developer", inviter: dmitry }
]

memberships.each do |membership|
  m = Membership.create!(membership.merge(joined_at: 60.days.ago))
  puts "Membership created for #{m.user.name} in #{m.workspace.name}"
end




# Подписки и платежи

mirk_subscription = Subscription.create!(workspace: mirk, plan: growth, status: "active", started_at: 4.months.ago, renews_at: 1.month.from_now)
zerno_subscription = Subscription.create!(workspace: zerno, plan: start, status: "active", started_at: 3.months.ago, renews_at: 1.month.from_now)
ulybka_subscription = Subscription.create!(workspace: ulybka, plan: growth, status: "active", started_at: 3.months.ago, renews_at: 1.month.from_now)
Subscription.create!(workspace: kvadrat, plan: agency, status: "trial", started_at: 5.days.ago, renews_at: 9.days.from_now, trial_ends_at: 9.days.from_now.to_date)

[ mirk_subscription, zerno_subscription, ulybka_subscription ].each do |subscription|
  3.times do |i|
    Payment.create!(
      subscription: subscription,
      amount: subscription.plan.price_month,
      currency: "RUB",
      status: "succeeded",
      provider: "ЮKassa",
      paid_at: (3 - i).months.ago
    )
  end
end

puts "Подписки созданы: #{Subscription.count}"
puts "Платежи созданы: #{Payment.count}"




# Сайты

mirk_site = Site.create!(workspace: mirk, domain: "mirk.msk.ru", brand_name: "МИРК", cms: "tilda", site_type: "multipage", pages_plan: "100 - 500", region: "Москва", verified: true, geo_score: 82.4, aeo_score: 79.6, seo_score: 81.9, created_at: 4.months.ago)
pinterest_site = Site.create!(workspace: mirk, domain: "pinterest.ru", brand_name: "МИРК", cms: "custom", site_type: "multipage", pages_plan: "20 - 100", region: "Москва", verified: true, geo_score: 71.0, aeo_score: 66.2, seo_score: 80.3, created_at: 3.months.ago)
overwolf_site = Site.create!(workspace: mirk, domain: "overwolf.ru", brand_name: "МИРК", cms: "tilda", site_type: "landing", pages_plan: "1 - 5", region: "Москва", verified: false, geo_score: 58.1, aeo_score: 49.4, seo_score: 70.2, created_at: 2.months.ago)
zerno_site = Site.create!(workspace: zerno, domain: "zerno-coffee.ru", cms: "tilda", site_type: "landing", region: "Москва", verified: true, geo_score: 48.5, aeo_score: 39.0, seo_score: 71.2)
ulybka_site = Site.create!(workspace: ulybka, domain: "ulybka-dent.ru", cms: "wordpress", site_type: "multipage", region: "Казань", verified: true, geo_score: 62.3, aeo_score: 55.8, seo_score: 80.4)
kvadrat_site = Site.create!(workspace: kvadrat, domain: "kvadrat-remont.ru", cms: "bitrix", site_type: "multipage", region: "Санкт-Петербург", verified: true, geo_score: 41.7, aeo_score: 33.5, seo_score: 66.0)

puts "Сайты созданы: #{Site.count}"




# Интеграции

integrations = [
  { site: mirk_site, provider: "webmaster", status: "connected" },
  { site: mirk_site, provider: "metrika", status: "connected" },
  { site: mirk_site, provider: "cms", status: "connected" },
  { site: pinterest_site, provider: "gsc", status: "connected" },
  { site: overwolf_site, provider: "cms", status: "pending" },
  { site: zerno_site, provider: "webmaster", status: "connected" },
  { site: ulybka_site, provider: "gsc", status: "error" },
  { site: kvadrat_site, provider: "github", status: "connected" }
]

integrations.each do |integration|
  Integration.create!(
    integration.merge(
      token_ref: "vault://#{integration[:site].domain}/#{integration[:provider]}",
      connected_at: integration[:status] == "pending" ? nil : 30.days.ago
    )
  )
end

puts "Интеграции созданы: #{Integration.count}"




# Страницы

mirk_home = Page.create!(site: mirk_site, url: "https://mirk.msk.ru/", title: "МИРК - курсы повышения квалификации в Москве", page_type: "home", has_schema: true, score: 84.0, last_crawled_at: 1.hour.ago)
mirk_massage = Page.create!(site: mirk_site, url: "https://mirk.msk.ru/kursy/massazh", title: "Курсы массажа в Москве", page_type: "service", has_schema: true, score: 86.5, last_crawled_at: 1.hour.ago)
mirk_hirudo = Page.create!(site: mirk_site, url: "https://mirk.msk.ru/kursy/girudoterapiya", title: "Обучение по курсу Гирудотерапия в Москве", page_type: "service", has_schema: false, score: 77.0, last_crawled_at: 1.hour.ago)
Page.create!(site: mirk_site, url: "https://mirk.msk.ru/faq", title: "Частые вопросы об обучении", page_type: "faq", has_schema: true, score: 80.0, last_crawled_at: 1.hour.ago)
Page.create!(site: pinterest_site, url: "https://pinterest.ru/", title: "Главная", page_type: "home", has_schema: false, score: 71.0, last_crawled_at: 2.hours.ago)
Page.create!(site: overwolf_site, url: "https://overwolf.ru/", title: "Лендинг курса", page_type: "home", has_schema: false, score: 55.5, last_crawled_at: 3.hours.ago)
zerno_faq = Page.create!(site: zerno_site, url: "https://zerno-coffee.ru/faq", title: "Частые вопросы", page_type: "faq", has_schema: false, score: 38.0, last_crawled_at: 3.hours.ago)
ulybka_article = Page.create!(site: ulybka_site, url: "https://ulybka-dent.ru/stati/kak-vybrat-implant", title: "Как выбрать имплант: гид для пациентов", page_type: "article", has_schema: false, score: 58.0, last_crawled_at: 5.hours.ago)
kvadrat_home = Page.create!(site: kvadrat_site, url: "https://kvadrat-remont.ru/", title: "Ремонт квартир под ключ в Санкт-Петербурге", page_type: "home", has_schema: false, score: 44.0, last_crawled_at: 1.day.ago)

puts "Страницы созданы: #{Page.count}"




# Проверки сайтов

Site.all.each do |site|
  24.times do |hour|
    HealthCheck.create!(
      site: site,
      checked_at: hour.hours.ago.beginning_of_hour,
      http_status: 200,
      response_ms: 240 + (hour % 5) * 35,
      uptime_pct: 99.9,
      lcp_ms: site.site_type == "landing" ? 3600 : 2300,
      cls: 0.07,
      is_indexable: true
    )
  end
end

HealthCheck.create!(site: overwolf_site, checked_at: 5.hours.ago.beginning_of_hour, http_status: 500, response_ms: 5400, uptime_pct: 97.9, lcp_ms: 0, cls: 0, is_indexable: false)

puts "Проверки созданы: #{HealthCheck.count}"




# Запросы и позиции сайтов МИРК за год

mirk_queries = [
  [ Query.create!(site: mirk_site, text: "курсы массажа в Москве", intent: "commercial", region: "Москва", is_tracked: true), 2, -1 ],
  [ Query.create!(site: mirk_site, text: "обучение по курсу гирудотерапия в Москве", intent: "commercial", region: "Москва", is_tracked: true), 1, 1 ],
  [ Query.create!(site: mirk_site, text: "курсы косметолога с нуля", intent: "commercial", region: "Москва", is_tracked: true), 4, -1 ],
  [ Query.create!(site: mirk_site, text: "повышение квалификации медсестер", intent: "info", region: "Москва", is_tracked: true), 4, 0 ],
  [ Query.create!(site: pinterest_site, text: "курсы медсестер онлайн", intent: "commercial", region: "Москва", is_tracked: true), 3, -1 ],
  [ Query.create!(site: pinterest_site, text: "обучение медицинскому массажу", intent: "commercial", region: "Москва", is_tracked: true), 5, 1 ],
  [ Query.create!(site: pinterest_site, text: "как стать косметологом без медобразования", intent: "info", region: "Москва", is_tracked: true), 6, -2 ],
  [ Query.create!(site: overwolf_site, text: "курс кинезиотейпирования", intent: "commercial", region: "Москва", is_tracked: true), 7, -2 ],
  [ Query.create!(site: overwolf_site, text: "курсы косметологии с дипломом", intent: "commercial", region: "Москва", is_tracked: true), 9, 1 ]
]

52.times do |week|
  date = week.weeks.ago.to_date
  mention_level = (4 + 4 * Math.sin(week / 6.0)).round

  mirk_queries.each_with_index do |(query, position, shift), q|
    position += shift if date >= 30.days.ago.to_date

    engines.each_with_index do |engine, e|
      mentioned = (week * 7 + q * 3 + e * 5) % 10 < mention_level

      PositionSnapshot.create!(
        query: query,
        engine: engine,
        checked_at: date,
        position: mentioned ? position : nil,
        is_mentioned: mentioned,
        is_cited: mentioned && position <= 3,
        cited_url: mentioned ? "https://#{query.site.domain}/" : nil,
        sentiment: mentioned ? "positive" : nil,
        share_of_voice: mentioned ? (1.0 / position).round(2) : 0
      )
    end
  end
end

puts "Снимки позиций сайтов МИРК созданы: #{PositionSnapshot.count}"




# Запросы и конкуренты других клиентов

zerno_query = Query.create!(site: zerno_site, text: "кофейня рядом с метро Китай-город", intent: "local", region: "Москва", is_tracked: true)
ulybka_query = Query.create!(site: ulybka_site, text: "имплантация зубов цена Казань", intent: "commercial", region: "Казань", is_tracked: true)
kvadrat_query = Query.create!(site: kvadrat_site, text: "ремонт квартиры под ключ СПб цена", intent: "commercial", region: "Санкт-Петербург", is_tracked: true)

Competitor.create!(site: mirk_site, domain: "medcourses.ru", name: "Медкурсы", author: ekaterina)
kofe_tochka = Competitor.create!(site: zerno_site, domain: "kofe-tochka.ru", name: "Кофе Точка", author: anna)
dentaplus = Competitor.create!(site: ulybka_site, domain: "dentaplus-kzn.ru", name: "Дента Плюс", author: igor)
remont_pro = Competitor.create!(site: kvadrat_site, domain: "remont-spb-pro.ru", name: "Ремонт СПб Про", author: dmitry)

[ [ zerno_query, kofe_tochka, 4, 2 ], [ ulybka_query, dentaplus, 2, 1 ], [ kvadrat_query, remont_pro, 6, 2 ] ].each do |query, competitor, own_position, competitor_position|
  engines.each do |engine|
    7.times do |day|
      PositionSnapshot.create!(query: query, engine: engine, checked_at: day.days.ago.to_date, position: own_position, is_mentioned: true, is_cited: false, sentiment: "neutral", share_of_voice: (1.0 / own_position).round(2))
      PositionSnapshot.create!(query: query, engine: engine, competitor: competitor, checked_at: day.days.ago.to_date, position: competitor_position, is_mentioned: true, is_cited: true, cited_url: "https://#{competitor.domain}/", sentiment: "neutral", share_of_voice: (1.0 / competitor_position).round(2))
    end
  end
end

puts "Конкуренты созданы: #{Competitor.count}"
puts "Снимки позиций всего: #{PositionSnapshot.count}"




# Аудиты, проблемы и рекомендации

mirk_audit = Audit.create!(site: mirk_site, kind: "full", trigger: "scheduled", status: "done", total_score: 81.3, started_at: 1.day.ago, finished_at: 1.day.ago + 18.minutes)
Audit.create!(site: overwolf_site, kind: "full", trigger: "onboarding", status: "queued", started_at: 10.minutes.ago)
zerno_audit = Audit.create!(site: zerno_site, kind: "full", trigger: "onboarding", status: "done", total_score: 46.0, started_at: 7.days.ago, finished_at: 7.days.ago + 20.minutes)
ulybka_audit = Audit.create!(site: ulybka_site, kind: "aeo", trigger: "scheduled", status: "done", total_score: 58.5, started_at: 3.days.ago, finished_at: 3.days.ago + 15.minutes)
kvadrat_audit = Audit.create!(site: kvadrat_site, kind: "full", trigger: "onboarding", status: "done", total_score: 38.0, started_at: 10.days.ago, finished_at: 10.days.ago + 30.minutes)

alt_issue = Issue.create!(audit: mirk_audit, page: mirk_massage, category: "seo", severity: "medium", title: "У изображений нет alt-текста", description: "Нейросети и поисковики не понимают, что изображено на фото курсов.", status: "open", first_seen_at: 1.day.ago)
hirudo_issue = Issue.create!(audit: mirk_audit, page: mirk_hirudo, category: "aeo", severity: "high", title: "Нет краткого ответа в начале страницы", description: "Цена и длительность курса спрятаны в середине текста, поэтому ИИ не берёт их в ответ.", status: "in_progress", first_seen_at: 1.day.ago)
faq_issue = Issue.create!(audit: zerno_audit, page: zerno_faq, category: "aeo", severity: "high", title: "Нет разметки FAQPage на странице вопросов", description: "Без разметки ИИ-поиск не может уверенно взять ответы в выдачу.", status: "open", first_seen_at: 7.days.ago)
author_issue = Issue.create!(audit: ulybka_audit, page: ulybka_article, category: "aeo", severity: "medium", title: "У статьи нет даты обновления и автора", description: "Без этих данных статья выглядит менее надёжной.", status: "open", first_seen_at: 3.days.ago)
robots_issue = Issue.create!(audit: kvadrat_audit, page: kvadrat_home, category: "tech", severity: "critical", title: "robots.txt закрывает доступ ИИ-краулерам", description: "В robots.txt запрещены GPTBot и YandexAdditional.", status: "fixed", first_seen_at: 10.days.ago)

alt_recommendation = Recommendation.create!(issue: alt_issue, title: "Добавить alt-text изображениям", explanation: "Короткое описание каждого фото помогает ИИ понять содержание страницы.", expected_impact: "mid", effort: "S", priority: 3, status: "accepted")
hirudo_recommendation = Recommendation.create!(issue: hirudo_issue, title: "Добавить краткий ответ в начало статьи", explanation: "Два предложения с ценой и сроком обучения в самом начале страницы.", expected_impact: "high", effort: "S", priority: 2, status: "accepted")
faq_recommendation = Recommendation.create!(issue: faq_issue, title: "Добавить JSON-LD разметку FAQPage", explanation: "Разметка явно связывает вопрос и ответ.", expected_impact: "high", effort: "S", priority: 2, status: "accepted")
Recommendation.create!(issue: author_issue, title: "Показать дату обновления и автора статьи", explanation: "Дата и автор - сигналы экспертности для ИИ-поисковиков.", expected_impact: "low", effort: "S", priority: 3, status: "proposed")
robots_recommendation = Recommendation.create!(issue: robots_issue, title: "Открыть сайт для ИИ-краулеров в robots.txt", explanation: "Разрешите обход ботам ИИ-поисковиков.", expected_impact: "high", effort: "S", priority: 1, status: "done")

CodePatch.create!(recommendation: alt_recommendation, target: "html", language: "HTML", code: "<img src=\"/img/massazh.jpg\" alt=\"Практическое занятие на курсе массажа в МИРК\">\n", applied: false)
CodePatch.create!(recommendation: faq_recommendation, target: "json-ld", language: "JSON", code: "<script type=\"application/ld+json\">\n{ \"@context\": \"https://schema.org\", \"@type\": \"FAQPage\" }\n</script>\n", applied: false)
CodePatch.create!(recommendation: robots_recommendation, target: "robots", language: "Plain Text", file_path: "/robots.txt", code: "User-agent: GPTBot\nAllow: /\n\nUser-agent: YandexAdditional\nAllow: /\n", applied: true, verified_at: 8.days.ago)

puts "Аудиты созданы: #{Audit.count}"
puts "Проблемы созданы: #{Issue.count}"
puts "Рекомендации созданы: #{Recommendation.count}"




# Задачи

tasks = [
  { site: mirk_site, title: "Добавить alt-text изображениям", priority: 3, status: "todo", recommendation: alt_recommendation },
  { site: mirk_site, title: "Добавить краткий ответ в начало статьи", priority: 2, status: "todo", recommendation: hirudo_recommendation },
  { site: mirk_site, title: "Указать источники статистики", priority: 3, status: "todo" },
  { site: mirk_site, title: "Добавить FAQ на страницу курса косметолога", priority: 2, status: "todo" },
  { site: mirk_site, title: "Обновить даты на страницах курсов", priority: 1, status: "todo" },
  { site: mirk_site, title: "Добавить цитаты экспертов", priority: 3, status: "doing", assignee: dzhabbar },
  { site: mirk_site, title: "Уточнить сведения о компании на сайте", priority: 1, status: "doing", assignee: ekaterina },
  { site: mirk_site, title: "Добавить robots.txt", priority: 3, status: "done", assignee: dzhabbar },
  { site: pinterest_site, title: "Настроить микроразметку Organization", priority: 2, status: "todo" },
  { site: overwolf_site, title: "Починить форму заявки на лендинге", priority: 3, status: "doing" },
  { site: zerno_site, title: "Добавить JSON-LD разметку FAQPage", priority: 2, status: "doing", recommendation: faq_recommendation, assignee: pavel },
  { site: kvadrat_site, title: "Открыть сайт для ИИ-краулеров в robots.txt", priority: 3, status: "done", recommendation: robots_recommendation, assignee: pavel }
]

tasks.each do |task|
  t = Task.create!(task.merge(creator: task[:site].workspace.owner, due_date: 7.days.from_now.to_date))
  puts "Task created: #{t.title}"
end




# Отчёты

Site.all.each do |site|
  4.times do |week|
    date_to = (week * 7).days.ago.to_date

    Report.create!(
      site: site,
      period: "weekly",
      date_from: date_to - 6.days,
      date_to: date_to,
      summary: "GEO #{site.geo_score}, AEO #{site.aeo_score}, SEO #{site.seo_score}. Открытых проблем: #{site.issues.where(status: 'open').count}.",
      file_url: "/reports/#{site.domain}-#{date_to}.pdf",
      sent_at: date_to.to_time.change(hour: 9)
    )
  end
end

puts "Отчёты созданы: #{Report.count}"




# Советы

content = Category.create!(name: "Контент")
tech = Category.create!(name: "Технологии")
analytics = Category.create!(name: "Аналитика")
geo = Category.create!(name: "GEO и AEO")

puts "Категории созданы: #{Category.count}"

articles = [
  {
    category: geo, title: "Как попасть в ответы ИИ", lead: "Основы GEO и AEO для вашего сайта", image: "okula/tip-eye.png", read_time: 7,
    body: <<~TEXT
      Нейросети всё чаще отвечают на вопрос пользователя сами, а не показывают список ссылок. Чтобы компания попадала в такие ответы, сайт должен быть понятен не только людям, но и языковым моделям.

      ## Что такое GEO и AEO
      GEO - оптимизация под генеративные поисковики вроде Яндекс Нейро и ChatGPT. AEO - оптимизация под короткие ответы: чтобы ИИ взял фразу прямо с вашей страницы.

      ## С чего начать
      Проверьте, открыт ли сайт для ИИ-краулеров, есть ли на ключевых страницах короткий ответ в первых двух предложениях и размечены ли данные о компании.

      ## Что даёт результат
      Структурированный текст, разметка schema.org, страницы с ответами на частые вопросы и упоминания бренда на внешних площадках.
    TEXT
  },
  {
    category: content, title: "Зачем сайту FAQ", lead: "Короткие ответы, которые нейросети любят цитировать", image: "okula/tip-faq.png", read_time: 4,
    body: <<~TEXT
      Блок частых вопросов - самый простой способ попасть в ответ нейросети. Вопрос в нём уже сформулирован так, как его задаёт человек, а ответ короткий.

      ## Как выбрать вопросы
      Возьмите вопросы из заявок, чатов и звонков. Ещё больше подскажет Яндекс Вордстат и сам ИИ-помощник Okula.

      ## Как оформить
      Один вопрос - один короткий ответ на 2-3 предложения. Добавьте разметку FAQPage.

      ```
      <script type="application/ld+json">
      { "@context": "https://schema.org", "@type": "FAQPage" }
      </script>
      ```
    TEXT
  },
  {
    category: content, title: "Источники и цитаты", lead: "Почему ссылки на исследования повышают доверие", image: "okula/tip-quotes.png", read_time: 5,
    body: <<~TEXT
      Авторитетные источники и цитаты - важный инструмент GEO-оптимизации, который помогает повысить доверие к сайту и увеличить вероятность его использования в ответах искусственного интеллекта.

      ## Зачем нужны цитаты
      Нейросети стремятся предоставлять пользователям обоснованные ответы, поэтому особую ценность представляет контент, подкреплённый проверяемыми фактами.

      ## Почему важны для нейросети
      Ссылки на научные исследования, официальную статистику, отраслевые отчёты и мнения экспертов делают материал более убедительным и информативным.

      ## Как оформлять
      Используйте тег blockquote и указывайте источник в теге cite.

      ```
      <blockquote>
        <p>Words can be like X-rays, if you use them properly - they'll go through anything.</p>
        <cite>Brave New World</cite>
      </blockquote>
      ```

      ## Примеры удачных цитат
      Цифры из исследований с датой, слова практикующего эксперта с должностью, выдержки из стандартов и законов.

      ## Не злоупотребляйте
      Две-три сильные цитаты на страницу работают лучше, чем десять случайных.

      ## Вывод
      Проверяемые факты повышают доверие и людей, и нейросетей.
    TEXT
  },
  {
    category: tech, title: "Доступ для ИИ-ботов", lead: "Настройте robots.txt так, чтобы нейросети видели сайт", image: "okula/tip-chip.png", read_time: 3,
    body: <<~TEXT
      Если ИИ-краулер не может зайти на сайт, никакая оптимизация не поможет. Начните с проверки robots.txt.

      ## Каких ботов пустить
      GPTBot, OAI-SearchBot, PerplexityBot и YandexAdditional.

      ```
      User-agent: GPTBot
      Allow: /

      User-agent: YandexAdditional
      Allow: /
      ```

      ## Что закрыть
      Служебные разделы, корзину и личный кабинет.
    TEXT
  },
  {
    category: geo, title: "Ссылки и доверие", lead: "Как внешние упоминания влияют на ответы ИИ", image: "okula/tip-link.png", read_time: 6,
    body: <<~TEXT
      Нейросети опираются не только на ваш сайт. Отзывы, каталоги, статьи в СМИ и карточки на картах подтверждают, что компания существует и ей доверяют.

      ## Где получить упоминания
      Яндекс Карты, отраслевые каталоги, партнёрские сайты, профильные медиа.

      ## Как проверить результат
      Следите в Okula, как часто нейросети называют ваш бренд в ответах по ключевым запросам.
    TEXT
  },
  {
    category: analytics, title: "Как измерять видимость", lead: "Отслеживайте упоминания и цитирования", image: "okula/tip-chart.png", read_time: 10,
    body: <<~TEXT
      Классические позиции в поиске больше не показывают всю картину. Важно знать, как часто нейросети упоминают вас и ссылаются на ваш сайт.

      ## Главные метрики
      Количество упоминаний, доля цитирований, позиция в ответе и тональность.

      ## Как часто смотреть
      Раз в неделю для отчёта руководителю и сразу после крупных изменений на сайте.

      ## Где смотреть
      График упоминаний на дашборде Okula обновляется после каждой проверки.
    TEXT
  },
  {
    category: tech, title: "Что такое llms.txt", lead: "Короткая визитка сайта для языковых моделей", image: "okula/tip-eye.png", read_time: 4,
    body: <<~TEXT
      llms.txt - файл в корне сайта, где кратко описано, чем занимается компания и какие страницы главные.

      ## Что в нём писать
      Название, одно предложение о компании и список ключевых страниц со ссылками.

      ```
      # МИРК
      > Курсы повышения квалификации в Москве.

      - [Курсы массажа](https://mirk.msk.ru/kursy/massazh)
      ```
    TEXT
  },
  {
    category: content, title: "Структура страницы для нейросетей", lead: "Заголовки, списки и короткие абзацы", image: "okula/tip-faq.png", read_time: 5,
    body: <<~TEXT
      ИИ легче цитировать текст с понятной структурой: один заголовок H1, подзаголовки по смыслу, короткие абзацы и списки.

      ## Правило первого экрана
      Ответ на главный вопрос страницы должен быть в первых двух предложениях.

      ## Что мешает
      Длинные абзацы, текст на картинках и важная информация внутри слайдеров.
    TEXT
  },
  {
    category: analytics, title: "Отчёт для руководителя", lead: "Как объяснить результаты GEO простыми словами", image: "okula/tip-chart.png", read_time: 6,
    body: <<~TEXT
      Руководителю важны не технические детали, а результат: стали ли нейросети чаще называть компанию и приводить клиентов.

      ## Что показать
      График упоминаний, топ продвигаемых страниц и список закрытых задач за период.

      ## Как часто
      Раз в месяц достаточно, если нет резких изменений.
    TEXT
  }
]

articles.each_with_index do |article, i|
  a = Article.create!(article.merge(created_at: (articles.size - i).days.ago))
  puts "Article created: #{a.title}"
end




# Диалоги

dialog = Conversation.create!(user: ekaterina, site: mirk_site, title: "Как улучшить показатели конкретной страницы в поиске Яндекс?")
Message.create!(conversation: dialog, role: "user", content: "Как улучшить показатели конкретной страницы в поиске Яндекс?", created_at: 1.day.ago.change(hour: 12, min: 30))
Message.create!(conversation: dialog, role: "agent", content: Message::DEFAULT_ANSWER, created_at: 1.day.ago.change(hour: 12, min: 31))

faq_dialog = Conversation.create!(user: ekaterina, site: mirk_site, title: "Зачем нам FAQ на странице курса?")
Message.create!(conversation: faq_dialog, role: "user", content: "Зачем нам FAQ на странице курса?")
answer, context = Message.answer_for("Зачем нам FAQ на странице курса?")
Message.create!(conversation: faq_dialog, role: "agent", content: answer, context_ref: context)

puts "Диалоги созданы: #{Conversation.count}"
puts "Сообщения созданы: #{Message.count}"




# Уведомления

notifications = [
  { user: ekaterina, type: "alert", channel: "telegram", payload: { title: "Лендинг недоступен: ошибка 500", site: "overwolf.ru" }, is_read: false, created_at: 2.hours.ago },
  { user: ekaterina, type: "drop", channel: "in_app", payload: { title: "Страница «Курсы косметолога с нуля» опустилась в Яндекс Нейро", site: "mirk.msk.ru" }, is_read: false, created_at: 1.day.ago },
  { user: ekaterina, type: "report", channel: "email", payload: { title: "Еженедельный отчёт готов", site: "mirk.msk.ru" }, is_read: true, created_at: 3.days.ago },
  { user: ekaterina, type: "drop", channel: "in_app", payload: { title: "ChatGPT перестал упоминать pinterest.ru по запросу «обучение медицинскому массажу»", site: "pinterest.ru" }, is_read: true, created_at: 5.days.ago },
  { user: ekaterina, type: "report", channel: "email", payload: { title: "Ежемесячный отчёт за сентябрь готов", site: "mirk.msk.ru" }, is_read: true, created_at: 4.weeks.ago },
  { user: anna, type: "report", channel: "email", payload: { title: "Еженедельный отчёт готов", site: "zerno-coffee.ru" }, is_read: false },
  { user: dmitry, type: "drop", channel: "in_app", payload: { title: "Падение позиций в Яндекс Нейро", site: "kvadrat-remont.ru" }, is_read: false }
]

notifications.each do |notification|
  Notification.create!(notification)
end

puts "Уведомления созданы: #{Notification.count}"




# Отзывы

Review.create!(company: "МИРК", author: "Джаббар Гулиев", position: "разработчик", geo_rate: 81.5, aeo_rate: 93.2, avatar: "okula/review-avatar.png",
               text: "Отличный сервис для GEO/AEO-оптимизации сайта под поисковые нейросети! Уже через 2 месяца заметили рост видимости бренда в AI-ответах на 45%, а количество целевых переходов увеличилось на 28%. Команда грамотно проработала контент и структуру сайта, всё объяснила простым языком и предоставила понятную аналитику. Результатом довольны, планируем продолжать сотрудничество!")
Review.create!(company: "Стоматология «Улыбка»", author: "Игорь Волков", position: "владелец", geo_rate: 74.0, aeo_rate: 80.5,
               text: "Раньше мы узнавали о проблемах сайта только по падению заявок. Теперь Okula присылает уведомление в Telegram в тот же час, а ИИ-помощник сразу подсказывает, что поправить.")
Review.create!(company: "Ремонт «Квадрат»", author: "Дмитрий Орлов", position: "маркетолог", geo_rate: 68.2, aeo_rate: 71.9,
               text: "У нас больше сорока лендингов на Тильде, следить за ними вручную было невозможно. В Okula все страницы в одном кабинете, а задачи для разработчика формируются сами.")

puts "Отзывы созданы: #{Review.count}"
