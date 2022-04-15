
ActiveRecord::Schema.define(version: 2022_04_15_060056) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "title", null: false
    t.text "content", null: false
    t.date "expired_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0, null: false
    t.integer "priority", default: 0, null: false
    t.bigint "user_id"
    t.index ["title"], name: "index_tasks_on_title", unique: true
    t.index ["user_id"], name: "index_tasks_on_user_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.text "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end
end
