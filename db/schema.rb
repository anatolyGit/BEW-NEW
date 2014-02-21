# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20131123113139) do

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "pa_links", :force => true do |t|
    t.integer  "project_id"
    t.integer  "status_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "category"
    t.string   "number"
    t.datetime "release_date"
    t.string   "name"
    t.datetime "submit_date"
    t.datetime "testup"
    t.float    "estimation"
    t.text     "urls"
    t.text     "content"
    t.integer  "user_id"
    t.boolean  "draft"
    t.string   "image_file"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "attached_file"
    t.string   "working"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "password_digest"
    t.integer  "authority",       :default => 0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "works", :force => true do |t|
    t.integer  "pa_link_id"
    t.string   "charge_name"
    t.string   "contact"
    t.string   "jobs"
    t.float    "estimation"
    t.datetime "release_date"
    t.string   "urls"
    t.string   "appended"
    t.datetime "deleted_at"
    t.integer  "updated_user_id"
    t.float    "track"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "attached_file"
    t.string   "check_name"
    t.datetime "submit_date"
    t.datetime "testup"
  end

end
