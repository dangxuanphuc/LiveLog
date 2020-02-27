# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_27_044617) do

  create_table "lives", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.string "place"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["date"], name: "index_lives_on_date"
    t.index ["name", "date"], name: "index_lives_on_name_and_date", unique: true
  end

  create_table "playings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "inst"
    t.bigint "user_id", null: false
    t.bigint "song_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["song_id"], name: "index_playings_on_song_id"
    t.index ["user_id", "song_id"], name: "index_playings_on_user_id_and_song_id", unique: true
    t.index ["user_id"], name: "index_playings_on_user_id"
  end

  create_table "songs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "artist"
    t.string "youtube_id"
    t.integer "order"
    t.time "time"
    t.bigint "live_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 1
    t.text "comment"
    t.index ["live_id"], name: "index_songs_on_live_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "furigana"
    t.string "nickname"
    t.string "email"
    t.integer "joined"
    t.boolean "admin", default: false
    t.string "password_digest"
    t.string "remember_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.boolean "public", default: false
    t.string "url"
    t.text "intro"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["furigana"], name: "index_users_on_furigana"
  end

  add_foreign_key "playings", "songs"
  add_foreign_key "playings", "users"
  add_foreign_key "songs", "lives", column: "live_id"
end
