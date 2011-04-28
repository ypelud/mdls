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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110422201802) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.datetime "created_at"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "fk_comments_user"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "menus", :force => true do |t|
    t.integer "menutype_id",                 :null => false
    t.integer "user_id",                     :null => false
    t.string  "title",       :default => "", :null => false
    t.date    "date"
    t.text    "description"
    t.text    "ingredients"
    t.string  "url"
  end

  add_index "menus", ["menutype_id"], :name => "fk_menus_menutype_id"
  add_index "menus", ["user_id"], :name => "fk_menus_user_id"

  create_table "menuslistes", :force => true do |t|
    t.integer "day",         :default => 0
    t.integer "when",        :default => 0
    t.integer "planning_id", :default => 0, :null => false
    t.integer "menu_id",     :default => 0, :null => false
  end

  add_index "menuslistes", ["menu_id"], :name => "fk_menuslistes_menu_id"
  add_index "menuslistes", ["planning_id"], :name => "fk_menuslistes_planning_id"

  create_table "menutypes", :force => true do |t|
    t.string "name", :limit => 50, :null => false
  end

  create_table "plannings", :force => true do |t|
    t.string   "name"
    t.boolean  "public",     :default => true
    t.integer  "user_id",    :default => 0,    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "plannings", ["user_id"], :name => "fk_plannings_user_id"

  create_table "profils", :force => true do |t|
    t.string  "layout_name", :default => ""
    t.string  "style_menu",  :default => ""
    t.integer "user_id",     :default => 0,  :null => false
    t.string  "first_day"
  end

  add_index "profils", ["user_id"], :name => "fk_profils_user"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
    t.string   "context",       :default => "tags"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",        :limit => 128, :default => "", :null => false
    t.integer  "sign_in_count",                       :default => 0,  :null => false
    t.integer  "failed_attempts",                     :default => 0,  :null => false
    t.datetime "last_request_at"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
