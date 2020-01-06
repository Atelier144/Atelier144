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

ActiveRecord::Schema.define(version: 2020_01_02_003053) do

  create_table "infinite_blocks_records", force: :cascade do |t|
    t.integer "user_id"
    t.integer "score"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "news", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_name"
    t.string "introduction"
    t.string "web_site"
    t.string "twitter_uid"
    t.string "twitter_url"
    t.boolean "is_published_introduction"
    t.boolean "is_published_twitter_url"
    t.string "new_password_hash"
    t.boolean "is_published_profile"
    t.boolean "is_published_url"
    t.boolean "is_published_records"
  end

end
