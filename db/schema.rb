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

ActiveRecord::Schema.define(:version => 20130220014419) do

  create_table "candidates", :force => true do |t|
    t.string   "name",           :null => false
    t.string   "email",          :null => false
    t.string   "phone",          :null => false
    t.string   "current_status"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "cats", :force => true do |t|
    t.integer  "candidate_id",   :null => false
    t.string   "name",           :null => false
    t.string   "current_status"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "cats", ["candidate_id"], :name => "index_cats_on_candidate_id"

  create_table "educations", :force => true do |t|
    t.integer  "candidate_id", :null => false
    t.string   "name",         :null => false
    t.date     "date_from",    :null => false
    t.date     "date_to",      :null => false
    t.text     "description"
    t.string   "url"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "educations", ["candidate_id"], :name => "index_educations_on_candidate_id"

  create_table "experiences", :force => true do |t|
    t.integer  "candidate_id", :null => false
    t.string   "name",         :null => false
    t.date     "date_from",    :null => false
    t.date     "date_to",      :null => false
    t.text     "description"
    t.string   "url"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "experiences", ["candidate_id"], :name => "index_experiences_on_candidate_id"

  create_table "motivations", :force => true do |t|
    t.integer  "candidate_id", :null => false
    t.string   "name",         :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "motivations", ["candidate_id"], :name => "index_motivations_on_candidate_id"

  create_table "open_source_projects", :force => true do |t|
    t.integer  "candidate_id", :null => false
    t.string   "name",         :null => false
    t.text     "description"
    t.string   "url"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "open_source_projects", ["candidate_id"], :name => "index_open_source_projects_on_candidate_id"

  create_table "pictures", :force => true do |t|
    t.integer  "owner_id",   :null => false
    t.string   "picture",    :null => false
    t.string   "legend"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "profile_links", :force => true do |t|
    t.integer  "candidate_id", :null => false
    t.string   "name",         :null => false
    t.string   "url",          :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "profile_links", ["candidate_id"], :name => "index_profile_links_on_candidate_id"

  create_table "recruiters", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "recruiters", ["email"], :name => "index_recruiters_on_email", :unique => true
  add_index "recruiters", ["reset_password_token"], :name => "index_recruiters_on_reset_password_token", :unique => true

  create_table "shells", :force => true do |t|
    t.text     "code_buffer"
    t.integer  "recruiter_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "shells", ["recruiter_id"], :name => "index_shells_on_recruiter_id"

  create_table "skills", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "owner_id",   :null => false
    t.string   "level",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "skills", ["owner_id"], :name => "index_skills_on_owner_id"

end
