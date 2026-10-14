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

puts "All data just destroyed"




# ИИ-движки

yandex_neuro = AIEngine.create!(name: "Яндекс Нейро", type: "ai_search", region: "Россия", is_active: true)
alice = AIEngine.create!(name: "Алиса", type: "llm", region: "Россия", is_active: true)
ai_overviews = AIEngine.create!(name: "AI Overviews", type: "ai_search", region: "Глобально", is_active: true)
chatgpt = AIEngine.create!(name: "ChatGPT", type: "llm", region: "Глобально", is_active: true)
perplexity = AIEngine.create!(name: "Perplexity", type: "ai_search", region: "Глобально", is_active: true)

puts "ИИ-движки созданы: #{AIEngine.count}"




# Тарифы

start = Plan.create!(
  name: "Старт",
  site_type: "landing",
  price_month: 1490,
  pages_limit: 10,
  domains_limit: 1,
  queries_limit: 20,
  features: [ "Еженедельный аудит", "Отчёт на почту", "5 ИИ-движков" ]
)

business = Plan.create!(
  name: "Бизнес",
  site_type: "multipage",
  price_month: 4990,
  pages_limit: 200,
  domains_limit: 3,
  queries_limit: 100,
  features: [ "Ежедневные проверки", "Патчи кода", "ИИ-агент", "Telegram-уведомления" ]
)

agency = Plan.create!(
  name: "Агентство",
  site_type: "multipage",
  price_month: 14990,
  pages_limit: 1000,
  domains_limit: 15,
  queries_limit: 500,
  features: [ "Всё из тарифа «Бизнес»", "Мониторинг конкурентов", "Интеграция с GitHub", "Приоритетная поддержка" ]
)

puts "Тарифы созданы: #{Plan.count}"




# Пользователи

anna = User.create!(name: "Анна Смирнова", email: "anna@example.com", role: "owner", telegram_id: "@anna_zerno", password: "test")
igor = User.create!(name: "Игорь Волков", email: "igor@example.com", role: "owner", password: "test")
dmitry = User.create!(name: "Дмитрий Орлов", email: "test@email.com", role: "owner", telegram_id: "@dmitry_kvadrat", password: "test")
maria = User.create!(name: "Мария Кузнецова", email: "maria@example.com", role: "owner", password: "test")
ekaterina = User.create!(name: "Екатерина Лебедева", email: "ekaterina@example.com", role: "marketer", password: "test")
pavel = User.create!(name: "Павел Соколов", email: "pavel@example.com", role: "developer", telegram_id: "@pavel_dev", password: "test")
olga = User.create!(name: "Ольга Морозова", email: "olga@example.com", role: "marketer", password: "test")
nikita = User.create!(name: "Никита Попов", email: "nikita@example.com", role: "developer", password: "test")
alina = User.create!(name: "Алина Новикова", email: "alina@example.com", role: "admin", password: "test")

puts "Пользователи созданы: #{User.count}"




# Клиенты

zerno = Workspace.create!(name: "Кофейня «Зерно»", legal_name: "ООО «Зерно»", industry: "Общепит", region: "Москва", owner: anna)
ulybka = Workspace.create!(name: "Стоматология «Улыбка»", legal_name: "ООО «Клиника Улыбка»", industry: "Медицина", region: "Казань", owner: igor)
kvadrat = Workspace.create!(name: "Ремонт «Квадрат»", legal_name: "ИП Орлов Д. А.", industry: "Ремонт и строительство", region: "Санкт-Петербург", owner: dmitry)
kod = Workspace.create!(name: "Онлайн-школа «Код»", legal_name: "ООО «Код Образование»", industry: "Образование", region: "Екатеринбург", owner: maria)

puts "Клиенты созданы: #{Workspace.count}"




# Участники команд

memberships = [
  { user: anna, workspace: zerno, role: "owner" },
  { user: ekaterina, workspace: zerno, role: "marketer", inviter: anna },
  { user: pavel, workspace: zerno, role: "developer", inviter: anna },

  { user: igor, workspace: ulybka, role: "owner" },
  { user: olga, workspace: ulybka, role: "marketer", inviter: igor },
  { user: nikita, workspace: ulybka, role: "developer", inviter: igor },

  { user: dmitry, workspace: kvadrat, role: "owner" },
  { user: alina, workspace: kvadrat, role: "admin", inviter: dmitry },
  { user: pavel, workspace: kvadrat, role: "developer", inviter: dmitry },

  { user: maria, workspace: kod, role: "owner" },
  { user: ekaterina, workspace: kod, role: "marketer", inviter: maria },
  { user: nikita, workspace: kod, role: "developer", inviter: maria }
]

memberships.each do |membership|
  m = Membership.create!(membership.merge(joined_at: 60.days.ago))
  puts "Membership created for #{m.user.name} in #{m.workspace.name}"
end




# Подписки и платежи

zerno_subscription = Subscription.create!(workspace: zerno, plan: start, status: "active", started_at: 3.months.ago, renews_at: 1.month.from_now)
ulybka_subscription = Subscription.create!(workspace: ulybka, plan: business, status: "active", started_at: 3.months.ago, renews_at: 1.month.from_now)
kvadrat_subscription = Subscription.create!(workspace: kvadrat, plan: agency, status: "active", started_at: 3.months.ago, renews_at: 1.month.from_now)
Subscription.create!(workspace: kod, plan: business, status: "trial", started_at: 5.days.ago, renews_at: 9.days.from_now, trial_ends_at: 9.days.from_now.to_date)

[ zerno_subscription, ulybka_subscription, kvadrat_subscription ].each do |subscription|
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

zerno_site = Site.create!(
  workspace: zerno,
  domain: "zerno-coffee.ru",
  cms: "tilda",
  site_type: "landing",
  region: "Москва",
  verified: true,
  geo_score: 48.5,
  aeo_score: 39.0,
  seo_score: 71.2
)

ulybka_site = Site.create!(
  workspace: ulybka,
  domain: "ulybka-dent.ru",
  cms: "wordpress",
  site_type: "multipage",
  region: "Казань",
  verified: true,
  geo_score: 62.3,
  aeo_score: 55.8,
  seo_score: 80.4
)

kvadrat_site = Site.create!(
  workspace: kvadrat,
  domain: "kvadrat-remont.ru",
  cms: "bitrix",
  site_type: "multipage",
  region: "Санкт-Петербург",
  verified: true,
  geo_score: 41.7,
  aeo_score: 33.5,
  seo_score: 66.0
)

kvadrat_design_site = Site.create!(
  workspace: kvadrat,
  domain: "kvadrat-dizain.ru",
  cms: "custom",
  site_type: "landing",
  region: "Санкт-Петербург",
  verified: false,
  geo_score: 29.4,
  aeo_score: 25.1,
  seo_score: 52.8
)

kod_site = Site.create!(
  workspace: kod,
  domain: "kod-school.ru",
  cms: "custom",
  site_type: "multipage",
  region: "Екатеринбург",
  verified: true,
  geo_score: 70.6,
  aeo_score: 64.2,
  seo_score: 84.9
)

puts "Сайты созданы: #{Site.count}"




# Интеграции

integrations = [
  { site: zerno_site, provider: "webmaster", status: "connected" },
  { site: zerno_site, provider: "metrika", status: "connected" },
  { site: ulybka_site, provider: "webmaster", status: "connected" },
  { site: ulybka_site, provider: "cms", status: "connected" },
  { site: ulybka_site, provider: "gsc", status: "error" },
  { site: kvadrat_site, provider: "webmaster", status: "connected" },
  { site: kvadrat_site, provider: "github", status: "connected" },
  { site: kvadrat_design_site, provider: "github", status: "pending" },
  { site: kod_site, provider: "gsc", status: "connected" },
  { site: kod_site, provider: "github", status: "connected" }
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

zerno_home = Page.create!(site: zerno_site, url: "https://zerno-coffee.ru/", title: "Кофейня «Зерно» - спешелти-кофе на Покровке", page_type: "home", has_schema: false, score: 52.0, last_crawled_at: 3.hours.ago)
zerno_menu = Page.create!(site: zerno_site, url: "https://zerno-coffee.ru/menu", title: "Меню и цены", page_type: "product", has_schema: false, score: 47.5, last_crawled_at: 3.hours.ago)
zerno_faq = Page.create!(site: zerno_site, url: "https://zerno-coffee.ru/faq", title: "Частые вопросы", page_type: "faq", has_schema: false, score: 38.0, last_crawled_at: 3.hours.ago)

ulybka_home = Page.create!(site: ulybka_site, url: "https://ulybka-dent.ru/", title: "Стоматология «Улыбка» в Казани", page_type: "home", has_schema: true, score: 74.0, last_crawled_at: 5.hours.ago)
ulybka_implants = Page.create!(site: ulybka_site, url: "https://ulybka-dent.ru/uslugi/implantaciya", title: "Имплантация зубов под ключ", page_type: "service", has_schema: false, score: 61.5, last_crawled_at: 5.hours.ago)
ulybka_article = Page.create!(site: ulybka_site, url: "https://ulybka-dent.ru/stati/kak-vybrat-implant", title: "Как выбрать имплант: гид для пациентов", page_type: "article", has_schema: false, score: 58.0, last_crawled_at: 5.hours.ago)
ulybka_faq = Page.create!(site: ulybka_site, url: "https://ulybka-dent.ru/faq", title: "Вопросы и ответы", page_type: "faq", has_schema: false, score: 49.0, last_crawled_at: 5.hours.ago)

kvadrat_home = Page.create!(site: kvadrat_site, url: "https://kvadrat-remont.ru/", title: "Ремонт квартир под ключ в Санкт-Петербурге", page_type: "home", has_schema: false, score: 44.0, last_crawled_at: 1.day.ago)
kvadrat_prices = Page.create!(site: kvadrat_site, url: "https://kvadrat-remont.ru/ceny", title: "Цены на ремонт", page_type: "product", has_schema: false, score: 51.0, last_crawled_at: 1.day.ago)
kvadrat_blog = Page.create!(site: kvadrat_site, url: "https://kvadrat-remont.ru/blog/smeta-remonta", title: "Из чего складывается смета ремонта", page_type: "article", has_schema: false, score: 39.5, last_crawled_at: 1.day.ago)
kvadrat_faq = Page.create!(site: kvadrat_site, url: "https://kvadrat-remont.ru/faq", title: "Ответы на частые вопросы", page_type: "faq", has_schema: false, score: 35.0, last_crawled_at: 1.day.ago)

kvadrat_design_home = Page.create!(site: kvadrat_design_site, url: "https://kvadrat-dizain.ru/", title: "Дизайн интерьера от студии «Квадрат»", page_type: "home", has_schema: false, score: 31.0, last_crawled_at: 2.days.ago)
Page.create!(site: kvadrat_design_site, url: "https://kvadrat-dizain.ru/portfolio", title: "Портфолио", page_type: "product", has_schema: false, score: 27.5, last_crawled_at: 2.days.ago)

kod_home = Page.create!(site: kod_site, url: "https://kod-school.ru/", title: "Онлайн-школа программирования «Код»", page_type: "home", has_schema: true, score: 82.0, last_crawled_at: 2.hours.ago)
kod_python = Page.create!(site: kod_site, url: "https://kod-school.ru/kursy/python", title: "Курс Python с нуля", page_type: "product", has_schema: true, score: 76.5, last_crawled_at: 2.hours.ago)
kod_blog = Page.create!(site: kod_site, url: "https://kod-school.ru/blog/kak-stat-programmistom", title: "Как стать программистом в 2026 году", page_type: "article", has_schema: false, score: 63.0, last_crawled_at: 2.hours.ago)
kod_faq = Page.create!(site: kod_site, url: "https://kod-school.ru/faq", title: "Частые вопросы об обучении", page_type: "faq", has_schema: true, score: 70.0, last_crawled_at: 2.hours.ago)

puts "Страницы созданы: #{Page.count}"




# Проверки сайтов

Site.all.each do |site|
  7.times do |day|
    HealthCheck.create!(
      site: site,
      checked_at: day.days.ago.change(hour: 6),
      http_status: 200,
      response_ms: 250 + day * 40,
      uptime_pct: 99.9,
      lcp_ms: site.site_type == "landing" ? 3800 : 2400,
      cls: 0.08,
      is_indexable: true
    )
  end
end

HealthCheck.create!(site: kvadrat_site, checked_at: 2.days.ago.change(hour: 14), http_status: 503, response_ms: 6200, uptime_pct: 97.4, lcp_ms: 0, cls: 0, is_indexable: false)

puts "Проверки созданы: #{HealthCheck.count}"




# Запросы

zerno_query_1 = Query.create!(site: zerno_site, text: "кофейня рядом с метро Китай-город", intent: "local", region: "Москва", is_tracked: true)
zerno_query_2 = Query.create!(site: zerno_site, text: "где выпить спешелти-кофе в Москве", intent: "info", region: "Москва", is_tracked: true)

ulybka_query_1 = Query.create!(site: ulybka_site, text: "имплантация зубов цена Казань", intent: "commercial", region: "Казань", is_tracked: true)
ulybka_query_2 = Query.create!(site: ulybka_site, text: "какой имплант лучше поставить", intent: "info", region: "Казань", is_tracked: true)
ulybka_query_3 = Query.create!(site: ulybka_site, text: "стоматология рядом со мной", intent: "local", region: "Казань", is_tracked: true)

kvadrat_query_1 = Query.create!(site: kvadrat_site, text: "ремонт квартиры под ключ СПб цена", intent: "commercial", region: "Санкт-Петербург", is_tracked: true)
kvadrat_query_2 = Query.create!(site: kvadrat_site, text: "сколько стоит ремонт однушки", intent: "info", region: "Санкт-Петербург", is_tracked: true)
kvadrat_design_query = Query.create!(site: kvadrat_design_site, text: "дизайн интерьера квартиры СПб", intent: "commercial", region: "Санкт-Петербург", is_tracked: true)

kod_query_1 = Query.create!(site: kod_site, text: "курсы программирования для начинающих", intent: "commercial", region: "Россия", is_tracked: true)
kod_query_2 = Query.create!(site: kod_site, text: "как стать программистом с нуля", intent: "info", region: "Россия", is_tracked: true)

puts "Запросы созданы: #{Query.count}"




# Конкуренты

kofe_tochka = Competitor.create!(site: zerno_site, domain: "kofe-tochka.ru", name: "Кофе Точка", author: anna)
dentaplus = Competitor.create!(site: ulybka_site, domain: "dentaplus-kzn.ru", name: "Дента Плюс", author: igor)
smile_clinic = Competitor.create!(site: ulybka_site, domain: "smile-clinic16.ru", name: "Смайл Клиник", author: olga)
remont_pro = Competitor.create!(site: kvadrat_site, domain: "remont-spb-pro.ru", name: "Ремонт СПб Про", author: dmitry)
interior_lab = Competitor.create!(site: kvadrat_design_site, domain: "interior-lab.ru", name: "Интерьер Лаб", author: dmitry)
it_start = Competitor.create!(site: kod_site, domain: "it-start-school.ru", name: "ИТ Старт", author: maria)

puts "Конкуренты созданы: #{Competitor.count}"




# Позиции

positions = [
  [ zerno_query_1, kofe_tochka, 4, 2 ],
  [ zerno_query_2, kofe_tochka, nil, 3 ],
  [ ulybka_query_1, dentaplus, 2, 1 ],
  [ ulybka_query_2, smile_clinic, 3, nil ],
  [ ulybka_query_3, dentaplus, 1, 4 ],
  [ kvadrat_query_1, remont_pro, 6, 2 ],
  [ kvadrat_query_2, remont_pro, nil, 5 ],
  [ kvadrat_design_query, interior_lab, nil, 1 ],
  [ kod_query_1, it_start, 2, 3 ],
  [ kod_query_2, it_start, 1, 2 ]
]

engines = [ yandex_neuro, alice, ai_overviews, chatgpt, perplexity ]

positions.each do |query, competitor, own_position, competitor_position|
  engines.each do |engine|
    7.times do |day|
      PositionSnapshot.create!(
        query: query,
        engine: engine,
        checked_at: day.days.ago.to_date,
        position: own_position,
        is_mentioned: own_position.present?,
        is_cited: own_position.present? && own_position <= 3,
        cited_url: own_position.present? && own_position <= 3 ? "https://#{query.site.domain}/" : nil,
        sentiment: own_position.present? ? "positive" : nil,
        share_of_voice: own_position.present? ? (1.0 / own_position).round(2) : 0
      )

      PositionSnapshot.create!(
        query: query,
        engine: engine,
        competitor: competitor,
        checked_at: day.days.ago.to_date,
        position: competitor_position,
        is_mentioned: competitor_position.present?,
        is_cited: competitor_position.present? && competitor_position <= 3,
        cited_url: competitor_position.present? && competitor_position <= 3 ? "https://#{competitor.domain}/" : nil,
        sentiment: competitor_position.present? ? "neutral" : nil,
        share_of_voice: competitor_position.present? ? (1.0 / competitor_position).round(2) : 0
      )
    end
  end
end

puts "Снимки позиций созданы: #{PositionSnapshot.count}"




# Аудиты

zerno_audit = Audit.create!(site: zerno_site, kind: "full", trigger: "onboarding", status: "done", total_score: 46.0, started_at: 7.days.ago, finished_at: 7.days.ago + 20.minutes)
ulybka_audit = Audit.create!(site: ulybka_site, kind: "aeo", trigger: "scheduled", status: "done", total_score: 58.5, started_at: 3.days.ago, finished_at: 3.days.ago + 15.minutes)
kvadrat_audit = Audit.create!(site: kvadrat_site, kind: "full", trigger: "onboarding", status: "done", total_score: 38.0, started_at: 10.days.ago, finished_at: 10.days.ago + 30.minutes)
kvadrat_design_audit = Audit.create!(site: kvadrat_design_site, kind: "geo", trigger: "manual", status: "done", total_score: 27.0, started_at: 2.days.ago, finished_at: 2.days.ago + 10.minutes)
kod_audit = Audit.create!(site: kod_site, kind: "geo", trigger: "scheduled", status: "done", total_score: 68.0, started_at: 1.day.ago, finished_at: 1.day.ago + 12.minutes)
Audit.create!(site: kod_site, kind: "seo", trigger: "manual", status: "running", started_at: 20.minutes.ago)

puts "Аудиты созданы: #{Audit.count}"




# Проблемы

llms_issue = Issue.create!(
  audit: zerno_audit,
  category: "geo",
  severity: "critical",
  title: "Отсутствует файл llms.txt",
  description: "ИИ-ассистенты не получают краткого описания сайта и списка ключевых страниц, поэтому реже ссылаются на него в ответах.",
  status: "open",
  first_seen_at: 7.days.ago
)

zerno_faq_issue = Issue.create!(
  audit: zerno_audit,
  page: zerno_faq,
  category: "aeo",
  severity: "high",
  title: "Нет разметки FAQPage на странице вопросов",
  description: "Вопросы и ответы есть в тексте, но без структурированной разметки ИИ-поиск не может уверенно взять их в ответ.",
  status: "in_progress",
  first_seen_at: 7.days.ago
)

zerno_lcp_issue = Issue.create!(
  audit: zerno_audit,
  page: zerno_home,
  category: "tech",
  severity: "high",
  title: "LCP выше 3,5 секунды на мобильных",
  description: "Главное изображение загружается слишком долго - страдают поведенческие факторы и оценка качества сайта.",
  status: "open",
  first_seen_at: 7.days.ago
)

ulybka_article_issue = Issue.create!(
  audit: ulybka_audit,
  page: ulybka_article,
  category: "aeo",
  severity: "medium",
  title: "У статьи нет даты обновления и автора",
  description: "ИИ-поиск предпочитает свежие материалы с понятным автором - без этих данных статья выглядит менее надёжной.",
  status: "open",
  first_seen_at: 3.days.ago
)

ulybka_answer_issue = Issue.create!(
  audit: ulybka_audit,
  page: ulybka_implants,
  category: "content",
  severity: "medium",
  title: "Ответ о цене спрятан в длинных абзацах",
  description: "Цена имплантации указана в середине текста, поэтому ИИ-поиск не берёт её в короткий ответ.",
  status: "fixed",
  first_seen_at: 3.days.ago
)

robots_issue = Issue.create!(
  audit: kvadrat_audit,
  category: "tech",
  severity: "critical",
  title: "robots.txt закрывает доступ ИИ-краулерам",
  description: "В robots.txt запрещены GPTBot и YandexAdditional: сайт не попадает в выдачу ИИ-поиска.",
  status: "fixed",
  first_seen_at: 10.days.ago
)

local_business_issue = Issue.create!(
  audit: kvadrat_audit,
  page: kvadrat_home,
  category: "geo",
  severity: "high",
  title: "Нет разметки LocalBusiness",
  description: "ИИ-поиск не может надёжно определить название, адрес и контакты компании.",
  status: "in_progress",
  first_seen_at: 10.days.ago
)

meta_issue = Issue.create!(
  audit: kvadrat_audit,
  page: kvadrat_prices,
  category: "seo",
  severity: "medium",
  title: "Дублируется meta description",
  description: "У страниц цен и главной одинаковое описание, поэтому поисковики хуже различают их содержание.",
  status: "open",
  first_seen_at: 10.days.ago
)

h1_issue = Issue.create!(
  audit: kvadrat_design_audit,
  page: kvadrat_design_home,
  category: "seo",
  severity: "high",
  title: "На главной нет заголовка H1",
  description: "Без H1 поисковикам сложнее понять основную тему страницы.",
  status: "open",
  first_seen_at: 2.days.ago
)

mentions_issue = Issue.create!(
  audit: kod_audit,
  category: "geo",
  severity: "low",
  title: "Бренд редко упоминается на внешних площадках",
  description: "ИИ-модели опираются на упоминания в отзывах, СМИ и каталогах. Внешних упоминаний школы пока мало.",
  status: "open",
  first_seen_at: 1.day.ago
)

puts "Проблемы созданы: #{Issue.count}"




# Рекомендации

llms_recommendation = Recommendation.create!(issue: llms_issue, title: "Создать llms.txt с описанием кофейни и ключевых страниц", explanation: "Файл в корне сайта помогает языковым моделям быстро понять, чем занимается компания и какие страницы цитировать.", expected_impact: "high", effort: "S", priority: 1, status: "proposed")
faq_recommendation = Recommendation.create!(issue: zerno_faq_issue, title: "Добавить JSON-LD разметку FAQPage", explanation: "Разметка FAQPage явно связывает вопрос и ответ - так их проще процитировать в блоке ответа ИИ.", expected_impact: "high", effort: "S", priority: 2, status: "accepted")
lcp_recommendation = Recommendation.create!(issue: zerno_lcp_issue, title: "Сжать главное изображение и добавить preload", explanation: "Перевод картинки в WebP и предзагрузка сокращают LCP до 2,5 секунды и ниже.", expected_impact: "mid", effort: "S", priority: 2, status: "proposed")
author_recommendation = Recommendation.create!(issue: ulybka_article_issue, title: "Показать дату обновления и автора статьи", explanation: "Дата и автор - сигналы экспертности и актуальности для ИИ-поисковиков.", expected_impact: "low", effort: "S", priority: 3, status: "proposed")
answer_recommendation = Recommendation.create!(issue: ulybka_answer_issue, title: "Вынести короткий ответ о цене в первые два предложения", explanation: "Формат «вопрос - короткий ответ - подробности» лучше всего подходит для цитирования в ответах ИИ.", expected_impact: "mid", effort: "M", priority: 3, status: "done")
robots_recommendation = Recommendation.create!(issue: robots_issue, title: "Открыть сайт для ИИ-краулеров в robots.txt", explanation: "Разрешите обход ботам ИИ-поисковиков, оставив закрытыми служебные разделы.", expected_impact: "high", effort: "S", priority: 1, status: "done")
local_business_recommendation = Recommendation.create!(issue: local_business_issue, title: "Добавить JSON-LD LocalBusiness на главную", explanation: "Структурированные данные о компании повышают шанс, что ИИ назовёт бренд в локальных ответах.", expected_impact: "high", effort: "M", priority: 2, status: "accepted")
meta_recommendation = Recommendation.create!(issue: meta_issue, title: "Написать уникальный description для каждой страницы", explanation: "Описание в 140–160 символов с главным ответом страницы помогает и классической выдаче, и ИИ-сниппетам.", expected_impact: "mid", effort: "M", priority: 3, status: "proposed")
h1_recommendation = Recommendation.create!(issue: h1_issue, title: "Добавить один H1 с основной темой страницы", explanation: "Заголовок H1 должен совпадать с главным запросом, по которому страница должна находиться.", expected_impact: "mid", effort: "S", priority: 2, status: "proposed")
Recommendation.create!(issue: mentions_issue, title: "Разместить школу в каталогах курсов и на картах", explanation: "Заполненные карточки и отзывы на внешних площадках увеличивают шанс попасть в ответы ИИ.", expected_impact: "high", effort: "L", priority: 4, status: "proposed")

puts "Рекомендации созданы: #{Recommendation.count}"




# Патчи кода

CodePatch.create!(
  recommendation: llms_recommendation,
  target: "llms.txt",
  language: "Markdown",
  file_path: "/llms.txt",
  code: "# Кофейня «Зерно»\n\n> Спешелти-кофейня на Покровке в Москве.\n\n## Ключевые страницы\n\n- [Меню и цены](https://zerno-coffee.ru/menu)\n- [Частые вопросы](https://zerno-coffee.ru/faq)\n",
  applied: false
)

CodePatch.create!(
  recommendation: faq_recommendation,
  target: "json-ld",
  language: "JSON",
  code: "<script type=\"application/ld+json\">\n{\n  \"@context\": \"https://schema.org\",\n  \"@type\": \"FAQPage\",\n  \"mainEntity\": [{\n    \"@type\": \"Question\",\n    \"name\": \"Можно ли взять кофе с собой?\",\n    \"acceptedAnswer\": { \"@type\": \"Answer\", \"text\": \"Да, любой напиток можно взять с собой в нашем стакане или в своей кружке.\" }\n  }]\n}\n</script>\n",
  applied: false
)

CodePatch.create!(
  recommendation: lcp_recommendation,
  target: "html",
  language: "HTML",
  code: "<link rel=\"preload\" as=\"image\" href=\"/images/hero.webp\" fetchpriority=\"high\">\n",
  applied: false
)

CodePatch.create!(
  recommendation: author_recommendation,
  target: "html",
  language: "HTML",
  code: "<p class=\"meta\">Обновлено <time datetime=\"2026-10-01\">1 октября 2026</time> · Автор: врач-имплантолог Р. Галиев</p>\n",
  applied: false
)

CodePatch.create!(
  recommendation: robots_recommendation,
  target: "robots",
  language: "Plain Text",
  file_path: "/robots.txt",
  code: "User-agent: GPTBot\nAllow: /\n\nUser-agent: YandexAdditional\nAllow: /\n\nUser-agent: *\nDisallow: /bitrix/\n\nSitemap: https://kvadrat-remont.ru/sitemap.xml\n",
  applied: true,
  verified_at: 8.days.ago
)

CodePatch.create!(
  recommendation: local_business_recommendation,
  target: "json-ld",
  language: "JSON",
  code: "<script type=\"application/ld+json\">\n{\n  \"@context\": \"https://schema.org\",\n  \"@type\": \"LocalBusiness\",\n  \"name\": \"Ремонт «Квадрат»\",\n  \"url\": \"https://kvadrat-remont.ru/\",\n  \"address\": { \"@type\": \"PostalAddress\", \"addressLocality\": \"Санкт-Петербург\" }\n}\n</script>\n",
  applied: false
)

CodePatch.create!(
  recommendation: meta_recommendation,
  target: "meta",
  language: "HTML",
  code: "<meta name=\"description\" content=\"Цены на ремонт квартир в Санкт-Петербурге: косметический, капитальный и дизайнерский ремонт за м².\">\n",
  applied: false
)

CodePatch.create!(
  recommendation: h1_recommendation,
  target: "html",
  language: "HTML",
  code: "<h1>Дизайн интерьера квартир в Санкт-Петербурге</h1>\n",
  applied: false
)

puts "Патчи кода созданы: #{CodePatch.count}"




# Задачи

tasks = [
  { recommendation: faq_recommendation, assignee: pavel, creator: anna, status: "doing", due_date: 3.days.from_now.to_date },
  { recommendation: answer_recommendation, assignee: nikita, creator: igor, status: "done", due_date: 1.day.ago.to_date },
  { recommendation: robots_recommendation, assignee: pavel, creator: dmitry, status: "done", due_date: 8.days.ago.to_date },
  { recommendation: local_business_recommendation, assignee: nil, creator: dmitry, status: "todo", due_date: 7.days.from_now.to_date }
]

tasks.each do |task|
  t = Task.create!(task)
  t.update!(external_url: "https://tracker.example.com/GEO-#{t.id}")
  puts "Task created with id #{t.id}"
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
      summary: "GEO #{site.geo_score}, AEO #{site.aeo_score}, SEO #{site.seo_score}. Открытых проблем: #{site.issues.where(status: 'open').count}. Доступность сайта 99,9%.",
      file_url: "/reports/#{site.domain}-#{date_to}.pdf",
      sent_at: date_to.to_time.change(hour: 9)
    )
  end
end

puts "Отчёты созданы: #{Report.count}"




# Диалоги

kvadrat_dialog = Conversation.create!(user: dmitry, site: kvadrat_site, title: "Почему упали позиции в Яндекс Нейро?")

Message.create!(conversation: kvadrat_dialog, role: "user", content: "Почему за неделю упали позиции в Яндекс Нейро?")
Message.create!(conversation: kvadrat_dialog, role: "agent", content: "Сайт перестал попадать в ответы после обновления robots.txt: в нём закрыт доступ ИИ-краулерам. Я подготовил патч - его можно применить за пару минут.", context_ref: "issue:#{robots_issue.id}")
Message.create!(conversation: kvadrat_dialog, role: "user", content: "Пришли, пожалуйста, что именно поменять.")
Message.create!(conversation: kvadrat_dialog, role: "agent", content: "Готово: патч лежит в рекомендации «Открыть сайт для ИИ-краулеров в robots.txt». После публикации я перепроверю позиции в течение суток.", context_ref: "issue:#{robots_issue.id}")

zerno_dialog = Conversation.create!(user: anna, site: zerno_site, title: "Что такое AEO простыми словами?")

Message.create!(conversation: zerno_dialog, role: "user", content: "Что такое AEO простыми словами?")
Message.create!(conversation: zerno_dialog, role: "agent", content: "AEO - оптимизация под ответы. Цель - чтобы ИИ-ассистент взял короткий ответ прямо с вашего сайта и сослался на него. Для этого важны структура текста, FAQ и разметка schema.org.")
Message.create!(conversation: zerno_dialog, role: "user", content: "С чего начать на нашем сайте?")
Message.create!(conversation: zerno_dialog, role: "agent", content: "Начните с разметки FAQPage на странице вопросов - это самая быстрая правка с высоким эффектом.", context_ref: "issue:#{zerno_faq_issue.id}")

ulybka_dialog = Conversation.create!(user: igor, site: ulybka_site, title: "Объясни отчёт для руководителя")

Message.create!(conversation: ulybka_dialog, role: "user", content: "Объясни последний отчёт для руководителя")
Message.create!(conversation: ulybka_dialog, role: "agent", content: "Коротко: доступность сайта 99,9%, AEO-оценка выросла на 6 пунктов, сайт стал чаще цитироваться в Perplexity. Главный риск - статьи без автора и даты.", context_ref: "issue:#{ulybka_article_issue.id}")

puts "Диалоги созданы: #{Conversation.count}"
puts "Сообщения созданы: #{Message.count}"




# Уведомления

notifications = [
  { user: anna, type: "report", channel: "email", payload: { title: "Еженедельный отчёт готов", site: "zerno-coffee.ru" }, is_read: true },
  { user: anna, type: "alert", channel: "telegram", payload: { title: "Найдены критичные проблемы", site: "zerno-coffee.ru" }, is_read: false },
  { user: igor, type: "report", channel: "email", payload: { title: "Еженедельный отчёт готов", site: "ulybka-dent.ru" }, is_read: false },
  { user: dmitry, type: "alert", channel: "telegram", payload: { title: "Сайт недоступен: ошибка 503", site: "kvadrat-remont.ru" }, is_read: true },
  { user: dmitry, type: "drop", channel: "in_app", payload: { title: "Падение позиций в Яндекс Нейро", site: "kvadrat-remont.ru" }, is_read: false },
  { user: maria, type: "report", channel: "email", payload: { title: "Первый отчёт по пробному периоду", site: "kod-school.ru" }, is_read: false },
  { user: pavel, type: "alert", channel: "in_app", payload: { title: "Вам назначена задача", site: "zerno-coffee.ru" }, is_read: false }
]

notifications.each do |notification|
  Notification.create!(notification)
end

puts "Уведомления созданы: #{Notification.count}"
