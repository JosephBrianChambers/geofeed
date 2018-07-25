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

ActiveRecord::Schema.define(version: 2018_07_25_204119) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "authors", force: :cascade do |t|
    t.string "avatar_url"
    t.string "name"
    t.string "email"
    t.integer "content_provider_id"
    t.string "handle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider_id"
    t.index ["content_provider_id"], name: "index_authors_on_content_provider_id"
    t.index ["email"], name: "index_authors_on_email"
    t.index ["handle"], name: "index_authors_on_handle"
    t.index ["name"], name: "index_authors_on_name"
  end

  create_table "content_providers", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_content_providers_on_code"
  end

  create_table "event_moments", force: :cascade do |t|
    t.integer "moment_id"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_moments_on_event_id"
    t.index ["moment_id"], name: "index_event_moments_on_moment_id"
  end

  create_table "events", force: :cascade do |t|
    t.geometry "loc_fence", limit: {:srid=>3857, :type=>"st_polygon"}
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["end_time"], name: "index_events_on_end_time"
    t.index ["loc_fence"], name: "index_events_on_loc_fence", using: :gist
    t.index ["start_time"], name: "index_events_on_start_time"
  end

  create_table "media", force: :cascade do |t|
    t.string "url"
    t.integer "moment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["moment_id"], name: "index_media_on_moment_id"
  end

  create_table "moments", force: :cascade do |t|
    t.geometry "loc", limit: {:srid=>3857, :type=>"st_point"}
    t.string "title"
    t.text "caption"
    t.integer "content_provider_id"
    t.string "provider_id"
    t.string "provider_author_id"
    t.index ["loc"], name: "index_moments_on_loc", using: :gist
  end

  create_table "provider_access_tokens", force: :cascade do |t|
    t.integer "user_id"
    t.string "token"
    t.datetime "expires_at"
    t.integer "content_provider_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_provider_id"], name: "index_provider_access_tokens_on_content_provider_id"
    t.index ["expires_at"], name: "index_provider_access_tokens_on_expires_at"
    t.index ["user_id"], name: "index_provider_access_tokens_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "content_provider_uid"
    t.string "content_provider_id"
    t.index ["content_provider_id"], name: "index_users_on_content_provider_id"
    t.index ["content_provider_uid"], name: "index_users_on_content_provider_uid"
    t.index ["email"], name: "index_users_on_email"
  end

end
