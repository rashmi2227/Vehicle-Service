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

ActiveRecord::Schema[7.0].define(version: 2023_06_04_125859) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "controllers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "Enduser"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_controllers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_controllers_on_reset_password_token", unique: true
  end

  create_table "handlers_logins", id: false, force: :cascade do |t|
    t.bigint "service_handler_id", null: false
    t.bigint "user_id", null: false
    t.index ["service_handler_id", "user_id"], name: "index_handlers_logins_on_handler_id_and_login_id"
    t.index ["user_id", "service_handler_id"], name: "index_handlers_logins_on_login_id_and_handler_id"
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.bigint "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.bigint "resource_owner_id"
    t.bigint "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.string "scopes"
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "servicerequest_id", null: false
    t.bigint "vehicle_id", null: false
    t.bigint "user_id", null: false
    t.integer "amount"
    t.string "payment_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["servicerequest_id"], name: "index_payments_on_servicerequest_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
    t.index ["vehicle_id"], name: "index_payments_on_vehicle_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "reviewable_type", null: false
    t.bigint "reviewable_id", null: false
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_logins_id", null: false
    t.index ["reviewable_type", "reviewable_id"], name: "index_reviews_on_reviewable"
    t.index ["user_logins_id"], name: "index_reviews_on_user_logins_id"
  end

  create_table "service_handlers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "servicerequest_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "vehicle_number"
    t.bigint "vehicle_id", null: false
    t.bigint "employee_id", null: false
    t.index ["employee_id"], name: "index_service_handlers_on_employee_id"
    t.index ["servicerequest_id"], name: "index_service_handlers_on_servicerequest_id"
    t.index ["user_id"], name: "index_service_handlers_on_user_id"
    t.index ["vehicle_id"], name: "index_service_handlers_on_vehicle_id"
  end

  create_table "service_handlers_user_logins", id: false, force: :cascade do |t|
    t.bigint "service_handler_id", null: false
    t.bigint "user_login_id", null: false
  end

  create_table "service_handlers_users", id: false, force: :cascade do |t|
    t.bigint "service_handler_id", null: false
    t.bigint "user_id", null: false
    t.index ["service_handler_id", "user_id"], name: "index_service_handlers_users_on_service_handler_id_and_user_id"
    t.index ["user_id", "service_handler_id"], name: "index_service_handlers_users_on_user_id_and_service_handler_id"
  end

  create_table "servicerequests", force: :cascade do |t|
    t.string "status"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "primary_technician_id"
    t.integer "user_id"
    t.integer "vehicle_id"
    t.index ["primary_technician_id"], name: "index_servicerequests_on_primary_technician_id"
  end

  create_table "user_logins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "phone_no"
    t.string "role"
    t.string "user_name"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["email"], name: "index_user_logins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_user_logins_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "vehicle_modal"
    t.date "purchase_date"
    t.string "make"
    t.string "color"
    t.string "vehicle_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  add_foreign_key "servicerequests", "user_logins", column: "primary_technician_id"
end
