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

ActiveRecord::Schema.define(version: 2018_11_09_155933) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_docs", force: :cascade do |t|
    t.bigint "document_id"
    t.bigint "user_id"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_access_docs_on_document_id"
    t.index ["user_id"], name: "index_access_docs_on_user_id"
  end

  create_table "access_templates", force: :cascade do |t|
    t.bigint "template_id"
    t.bigint "user_id"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["template_id"], name: "index_access_templates_on_template_id"
    t.index ["user_id"], name: "index_access_templates_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "documents", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id"
    t.bigint "template_id"
    t.integer "scope"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "content"
    t.index ["template_id"], name: "index_documents_on_template_id"
    t.index ["user_id"], name: "index_documents_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "qtext"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "template_id"
    t.index ["template_id"], name: "index_questions_on_template_id"
  end

  create_table "templates", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id"
    t.bigint "category_id"
    t.integer "scope"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_templates_on_category_id"
    t.index ["user_id"], name: "index_templates_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "access_docs", "documents"
  add_foreign_key "access_docs", "users"
  add_foreign_key "access_templates", "templates"
  add_foreign_key "access_templates", "users"
  add_foreign_key "documents", "templates"
  add_foreign_key "documents", "users"
  add_foreign_key "questions", "templates"
  add_foreign_key "templates", "categories"
  add_foreign_key "templates", "users"
end
