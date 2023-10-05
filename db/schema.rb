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

ActiveRecord::Schema[7.0].define(version: 2023_10_05_111954) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "characters", force: :cascade do |t|
    t.string "name", null: false
    t.string "system_message", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "system_message_tokens", default: 0
    t.boolean "tts_enabled", default: false
    t.string "xi_voice_id"
    t.decimal "xi_similarity_boost"
    t.decimal "xi_stability"
    t.decimal "xi_style"
    t.string "openai_model"
    t.bigint "context_size", default: 0
    t.boolean "variable_temperature_enabled", default: false
    t.index ["name"], name: "unique_characters", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.string "role", null: false
    t.string "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "character_id"
    t.bigint "tokens", default: 0
    t.string "tts_file_path"
    t.decimal "temperature"
    t.index ["character_id"], name: "index_messages_on_character_id"
  end

  create_table "summaries", force: :cascade do |t|
    t.string "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "character_id"
    t.bigint "tokens", default: 0
    t.index ["character_id"], name: "index_summaries_on_character_id"
  end

  add_foreign_key "messages", "characters"
  add_foreign_key "summaries", "characters"
end
