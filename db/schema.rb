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

ActiveRecord::Schema[7.0].define(version: 2022_12_06_061557) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["jti"], name: "index_admins_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "sub_domain"
    t.boolean "okta_sso_login", default: false
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "destinations", force: :cascade do |t|
    t.integer "destination_type", default: 0
    t.string "resource_url"
    t.integer "network_distribution_id"
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_destinations_on_admin_id"
  end

  create_table "endpoint_groups", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "endpoint_type", default: 1
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_endpoint_groups_on_admin_id"
  end

  create_table "endpoints", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "location_id"
    t.integer "endpoint_group_id"
    t.integer "destination_id"
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_endpoints_on_admin_id"
    t.index ["destination_id"], name: "index_endpoints_on_destination_id"
    t.index ["endpoint_group_id"], name: "index_endpoints_on_endpoint_group_id"
    t.index ["location_id"], name: "index_endpoints_on_location_id"
  end

  create_table "integrations", force: :cascade do |t|
    t.string "name"
    t.string "client_id"
    t.string "client_secret"
    t.string "base_url"
    t.string "expires_in"
    t.string "refresh_token"
    t.string "access_token"
    t.string "code"
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_integrations_on_admin_id"
    t.index ["client_id"], name: "index_integrations_on_client_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "web_signage_id"
    t.string "description"
    t.index ["admin_id"], name: "index_locations_on_admin_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "template_id"
    t.integer "endpoint_id"
    t.integer "admin_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "packages", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.integer "duration", default: 0
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "status"
    t.bigint "user_id"
    t.bigint "package_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.index ["package_id"], name: "index_subscriptions_on_package_id"
    t.index ["status"], name: "index_subscriptions_on_status"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "templates", force: :cascade do |t|
    t.string "name"
    t.string "subject"
    t.string "body"
    t.string "audio"
    t.string "background_color"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "font_color"
    t.integer "admin_id"
    t.index ["admin_id"], name: "index_templates_on_admin_id"
    t.index ["user_id"], name: "index_templates_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "package_id"
    t.bigint "subscription_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["package_id"], name: "index_transactions_on_package_id"
    t.index ["subscription_id"], name: "index_transactions_on_subscription_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti", null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "role", default: 0
    t.boolean "bypass_user", default: false
    t.string "provider"
    t.string "uid"
    t.boolean "paid", default: false
    t.string "stripe_account_intent"
    t.integer "status", default: 0
    t.bigint "company_id"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["provider"], name: "index_users_on_provider"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["stripe_account_intent"], name: "index_users_on_stripe_account_intent"
    t.index ["uid"], name: "index_users_on_uid"
  end

  create_table "web_signages", force: :cascade do |t|
    t.string "name"
    t.integer "scroller_speed"
    t.string "landscape_title_width"
    t.string "landscape_title_height"
    t.string "landscape_title_top"
    t.string "landscape_title_left"
    t.string "landscape_description_width"
    t.string "landscape_description_height"
    t.string "landscape_description_top"
    t.string "landscape_description_left"
    t.string "potrait_title_width"
    t.string "potrait_title_height"
    t.string "potrait_title_top"
    t.string "potrait_title_left"
    t.string "potrait_description_width"
    t.string "potrait_description_height"
    t.string "potrait_description_top"
    t.string "potrait_description_left"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
