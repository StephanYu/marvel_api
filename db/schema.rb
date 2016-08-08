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

ActiveRecord::Schema.define(version: 20160807153951) do

  create_table "characters", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "characters_comics", id: false, force: :cascade do |t|
    t.integer "comic_id",     null: false
    t.integer "character_id", null: false
    t.index ["character_id"], name: "index_characters_comics_on_character_id"
    t.index ["comic_id"], name: "index_characters_comics_on_comic_id"
  end

  create_table "comics", force: :cascade do |t|
    t.string   "title"
    t.string   "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "comic_id"
    t.integer  "direction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comic_id"], name: "index_votes_on_comic_id"
  end

end
