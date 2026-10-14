# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_10_13_114210) do
  create_table "ai_engines", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.string "region"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "audits", force: :cascade do |t|
    t.integer "site_id", null: false
    t.string "kind"
    t.string "trigger"
    t.string "status"
    t.float "total_score"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_audits_on_site_id"
  end

  create_table "code_patches", force: :cascade do |t|
    t.integer "recommendation_id", null: false
    t.string "target"
    t.string "language"
    t.text "code"
    t.string "file_path"
    t.boolean "applied"
    t.datetime "verified_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recommendation_id"], name: "index_code_patches_on_recommendation_id"
  end

  create_table "competitors", force: :cascade do |t|
    t.integer "site_id", null: false
    t.string "domain"
    t.string "name"
    t.integer "added_by", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["added_by"], name: "index_competitors_on_added_by"
    t.index ["site_id"], name: "index_competitors_on_site_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "site_id"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_conversations_on_site_id"
    t.index ["user_id"], name: "index_conversations_on_user_id"
  end

  create_table "health_checks", force: :cascade do |t|
    t.integer "site_id", null: false
    t.datetime "checked_at"
    t.integer "http_status"
    t.integer "response_ms"
    t.float "uptime_pct"
    t.integer "lcp_ms"
    t.float "cls"
    t.boolean "is_indexable"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_health_checks_on_site_id"
  end

  create_table "integrations", force: :cascade do |t|
    t.integer "site_id", null: false
    t.string "provider"
    t.string "status"
    t.string "token_ref"
    t.datetime "connected_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_integrations_on_site_id"
  end

  create_table "issues", force: :cascade do |t|
    t.integer "audit_id", null: false
    t.integer "page_id"
    t.string "category"
    t.string "severity"
    t.string "title"
    t.text "description"
    t.string "status"
    t.datetime "first_seen_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["audit_id"], name: "index_issues_on_audit_id"
    t.index ["page_id"], name: "index_issues_on_page_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "workspace_id", null: false
    t.string "role"
    t.integer "invited_by"
    t.datetime "joined_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invited_by"], name: "index_memberships_on_invited_by"
    t.index ["user_id"], name: "index_memberships_on_user_id"
    t.index ["workspace_id"], name: "index_memberships_on_workspace_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "conversation_id", null: false
    t.string "role"
    t.text "content"
    t.string "context_ref"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "type"
    t.string "channel"
    t.json "payload"
    t.boolean "is_read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "pages", force: :cascade do |t|
    t.integer "site_id", null: false
    t.string "url"
    t.string "title"
    t.string "page_type"
    t.boolean "has_schema"
    t.float "score"
    t.datetime "last_crawled_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_pages_on_site_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "subscription_id", null: false
    t.integer "amount"
    t.string "currency"
    t.string "status"
    t.string "provider"
    t.datetime "paid_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscription_id"], name: "index_payments_on_subscription_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.string "site_type"
    t.integer "price_month"
    t.integer "pages_limit"
    t.integer "domains_limit"
    t.integer "queries_limit"
    t.json "features"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "position_snapshots", force: :cascade do |t|
    t.integer "query_id", null: false
    t.integer "engine_id", null: false
    t.integer "competitor_id"
    t.date "checked_at"
    t.integer "position"
    t.boolean "is_mentioned"
    t.boolean "is_cited"
    t.string "cited_url"
    t.string "sentiment"
    t.float "share_of_voice"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["competitor_id"], name: "index_position_snapshots_on_competitor_id"
    t.index ["engine_id"], name: "index_position_snapshots_on_engine_id"
    t.index ["query_id"], name: "index_position_snapshots_on_query_id"
  end

  create_table "queries", force: :cascade do |t|
    t.integer "site_id", null: false
    t.string "text"
    t.string "intent"
    t.string "region"
    t.boolean "is_tracked"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_queries_on_site_id"
  end

  create_table "recommendations", force: :cascade do |t|
    t.integer "issue_id", null: false
    t.string "title"
    t.text "explanation"
    t.string "expected_impact"
    t.string "effort"
    t.integer "priority"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["issue_id"], name: "index_recommendations_on_issue_id"
  end

  create_table "reports", force: :cascade do |t|
    t.integer "site_id", null: false
    t.string "period"
    t.date "date_from"
    t.date "date_to"
    t.text "summary"
    t.string "file_url"
    t.datetime "sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_reports_on_site_id"
  end

  create_table "sites", force: :cascade do |t|
    t.integer "workspace_id", null: false
    t.string "domain"
    t.string "cms"
    t.string "site_type"
    t.string "region"
    t.boolean "verified"
    t.float "geo_score"
    t.float "aeo_score"
    t.float "seo_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["domain"], name: "index_sites_on_domain", unique: true
    t.index ["workspace_id"], name: "index_sites_on_workspace_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "workspace_id", null: false
    t.integer "plan_id", null: false
    t.string "status"
    t.datetime "started_at"
    t.datetime "renews_at"
    t.date "trial_ends_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_subscriptions_on_plan_id"
    t.index ["workspace_id"], name: "index_subscriptions_on_workspace_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "recommendation_id", null: false
    t.integer "assignee_id"
    t.integer "created_by", null: false
    t.string "status"
    t.date "due_date"
    t.string "external_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignee_id"], name: "index_tasks_on_assignee_id"
    t.index ["created_by"], name: "index_tasks_on_created_by"
    t.index ["recommendation_id"], name: "index_tasks_on_recommendation_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "avatar"
    t.string "role"
    t.string "telegram_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workspaces", force: :cascade do |t|
    t.string "name"
    t.string "legal_name"
    t.string "industry"
    t.string "region"
    t.integer "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_workspaces_on_owner_id"
  end

  add_foreign_key "audits", "sites"
  add_foreign_key "code_patches", "recommendations"
  add_foreign_key "competitors", "sites"
  add_foreign_key "competitors", "users", column: "added_by"
  add_foreign_key "conversations", "sites"
  add_foreign_key "conversations", "users"
  add_foreign_key "health_checks", "sites"
  add_foreign_key "integrations", "sites"
  add_foreign_key "issues", "audits"
  add_foreign_key "issues", "pages"
  add_foreign_key "memberships", "users"
  add_foreign_key "memberships", "users", column: "invited_by"
  add_foreign_key "memberships", "workspaces"
  add_foreign_key "messages", "conversations"
  add_foreign_key "notifications", "users"
  add_foreign_key "pages", "sites"
  add_foreign_key "payments", "subscriptions"
  add_foreign_key "position_snapshots", "ai_engines", column: "engine_id"
  add_foreign_key "position_snapshots", "competitors"
  add_foreign_key "position_snapshots", "queries"
  add_foreign_key "queries", "sites"
  add_foreign_key "recommendations", "issues"
  add_foreign_key "reports", "sites"
  add_foreign_key "sites", "workspaces"
  add_foreign_key "subscriptions", "plans"
  add_foreign_key "subscriptions", "workspaces"
  add_foreign_key "tasks", "recommendations"
  add_foreign_key "tasks", "users", column: "assignee_id"
  add_foreign_key "tasks", "users", column: "created_by"
  add_foreign_key "workspaces", "users", column: "owner_id"
end
