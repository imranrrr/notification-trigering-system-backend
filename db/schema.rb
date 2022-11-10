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

ActiveRecord::Schema[7.0].define(version: 2022_11_10_130219) do
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

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "web_signage_id"
    t.string "description"
    t.index ["admin_id"], name: "index_locations_on_admin_id"
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

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
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
