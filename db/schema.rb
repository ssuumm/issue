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

ActiveRecord::Schema.define(version: 2019_02_16_080628) do

  create_table "issue_custom_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "issue_custom_id", null: false, comment: "課題カスタム項目値ID"
    t.integer "value", null: false, comment: "選択値(複数選択タイプ)"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "issue_custom_item_options", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "issue_custom_item_id", null: false, comment: "カスタム項目ID"
    t.string "label", null: false, comment: "選択肢の名称"
    t.integer "value", null: false, comment: "選択肢の値"
    t.integer "order_num", null: false, comment: "並び順"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "issue_custom_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "item_type", null: false, comment: "項目タイプ"
    t.string "name", null: false, comment: "項目名"
    t.integer "order_num", null: false, comment: "並び順"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "issue_customs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "issue_id", null: false, comment: "課題ID"
    t.integer "issue_custom_item_id", null: false, comment: "課題カスタム項目ID"
    t.string "text", comment: "テキスト項目の値"
    t.integer "selected_value", comment: "選択値(単一選択タイプ)"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "issues", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "title", comment: "タイトル"
    t.text "content", comment: "本文"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
