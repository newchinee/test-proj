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

ActiveRecord::Schema.define(:version => 20120824075237) do

  create_table "admin_users", :force => true do |t|
    t.string   "first_name",             :default => "", :null => false
    t.string   "last_name",              :default => "", :null => false
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

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "answers", :force => true do |t|
    t.string   "name"
    t.integer  "question_id"
    t.boolean  "correct_flag", :default => false
    t.integer  "score",        :default => 1
    t.text     "explanation"
    t.boolean  "deleted_flag", :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "questions", :force => true do |t|
    t.string   "name"
    t.integer  "quiz_id"
    t.integer  "score",        :default => 1
    t.boolean  "deleted_flag", :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "quizzes", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "category_id"
    t.boolean  "random_flag",  :default => false
    t.integer  "max_question", :default => 100
    t.boolean  "deleted_flag", :default => false
    t.integer  "time_allowed", :default => 30
    t.boolean  "completed",    :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "results", :force => true do |t|
    t.integer  "user_id"
    t.integer  "quiz_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "marks"
    t.text     "comment"
    t.integer  "retry_count", :default => 0
    t.integer  "time_taken",  :default => 0
    t.integer  "status",      :default => 0
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.datetime "resume_time"
  end

  create_table "user_answers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "quiz_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.string   "session_id"
    t.boolean  "completed_flag"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name",             :default => "", :null => false
    t.string   "last_name",              :default => "", :null => false
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

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
