# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170907174037) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_holders", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accounts", force: :cascade do |t|
    t.string   "number"
    t.string   "holder"
    t.integer  "bank_id"
    t.boolean  "active",     default: true
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "clabe"
    t.boolean  "deprecated", default: false
    t.index ["bank_id"], name: "index_accounts_on_bank_id", using: :btree
  end

  create_table "accounts_payment_methods", id: false, force: :cascade do |t|
    t.integer "payment_method_id", null: false
    t.integer "account_id",        null: false
    t.index ["payment_method_id", "account_id"], name: "index_payment_methods_accounts", using: :btree
  end

  create_table "banks", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "image"
  end

  create_table "cards", force: :cascade do |t|
    t.string   "number"
    t.boolean  "active",     default: false
    t.integer  "account_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["account_id"], name: "index_cards_on_account_id", using: :btree
  end

  create_table "cards_payment_methods", id: false, force: :cascade do |t|
    t.integer "payment_method_id", null: false
    t.integer "card_id",           null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "order_id"
    t.integer  "user_id"
    t.boolean  "user_read",  default: false
    t.boolean  "admin_read", default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["order_id"], name: "index_messages_on_order_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "recipient_id"
    t.datetime "read_at"
    t.string   "action"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "payment_method_id"
    t.decimal  "amount"
    t.integer  "price"
    t.boolean  "submitted",            default: false
    t.integer  "expires_in",           default: 3
    t.boolean  "completed",            default: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "address"
    t.string   "attachments",          default: [],                 array: true
    t.datetime "completed_at"
    t.integer  "authorized_by"
    t.datetime "expires_at"
    t.boolean  "removed",              default: false
    t.integer  "account_id"
    t.integer  "card_id"
    t.integer  "confirmed_account_id"
    t.integer  "confirmed_card_id"
    t.index ["account_id"], name: "index_orders_on_account_id", using: :btree
    t.index ["card_id"], name: "index_orders_on_card_id", using: :btree
    t.index ["confirmed_account_id"], name: "index_orders_on_confirmed_account_id", using: :btree
    t.index ["confirmed_card_id"], name: "index_orders_on_confirmed_card_id", using: :btree
    t.index ["payment_method_id"], name: "index_orders_on_payment_method_id", using: :btree
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string   "name"
    t.string   "method"
    t.text     "details"
    t.integer  "expires",      default: 3
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "schedule"
    t.text     "instructions"
    t.text     "notice"
    t.boolean  "active"
    t.boolean  "deprecated",   default: false
    t.string   "image"
  end

  create_table "settings", force: :cascade do |t|
    t.string   "key"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.boolean  "agreed_to_terms",        default: false
    t.boolean  "receives_notifs",        default: true
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "accounts", "banks"
  add_foreign_key "cards", "accounts"
  add_foreign_key "messages", "orders"
  add_foreign_key "messages", "users"
  add_foreign_key "orders", "accounts"
  add_foreign_key "orders", "cards"
  add_foreign_key "orders", "payment_methods"
  add_foreign_key "orders", "users"
end
