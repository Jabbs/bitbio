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

ActiveRecord::Schema.define(:version => 20130609103643) do

  create_table "attachments", :force => true do |t|
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "image"
  end

  add_index "attachments", ["attachable_type", "attachable_id"], :name => "index_attachments_on_attachable_type_and_attachable_id"

  create_table "blogs", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "slug"
    t.integer  "view_count", :default => 0
    t.string   "bitly_url"
  end

  add_index "blogs", ["slug"], :name => "index_blogs_on_slug"
  add_index "blogs", ["title"], :name => "index_blogs_on_title"
  add_index "blogs", ["user_id"], :name => "index_blogs_on_user_id"

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.datetime "new_comment_email_sent_at"
    t.string   "commentable_type"
    t.integer  "commentable_id"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "instruments", :force => true do |t|
    t.string   "alias"
    t.integer  "project_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.boolean  "must_have",  :default => true
  end

  add_index "instruments", ["alias"], :name => "index_instruments_on_name"
  add_index "instruments", ["project_id"], :name => "index_instruments_on_project_id"

  create_table "messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.integer  "project_id"
    t.text     "content"
    t.string   "subject"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.boolean  "viewed",                    :default => false
    t.datetime "new_message_email_sent_at"
  end

  add_index "messages", ["project_id"], :name => "index_messages_on_project_id"
  add_index "messages", ["receiver_id"], :name => "index_messages_on_receiver_id"
  add_index "messages", ["sender_id"], :name => "index_messages_on_sender_id"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "science_type"
    t.integer  "user_id"
    t.string   "service_need"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.date     "start_date"
    t.string   "slug"
    t.integer  "view_count",      :default => 0
    t.string   "visability",      :default => "public"
    t.boolean  "searchable",      :default => true
    t.boolean  "active",          :default => true
    t.date     "expiration_date"
    t.string   "bitly_url"
  end

  add_index "projects", ["active"], :name => "index_projects_on_active"
  add_index "projects", ["science_type"], :name => "index_projects_on_science_type"
  add_index "projects", ["searchable"], :name => "index_projects_on_searchable"
  add_index "projects", ["service_need"], :name => "index_projects_on_service_need"
  add_index "projects", ["slug"], :name => "index_projects_on_slug"
  add_index "projects", ["user_id"], :name => "index_projects_on_user_id"
  add_index "projects", ["visability"], :name => "index_projects_on_visability"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "taggings", ["project_id"], :name => "index_taggings_on_project_id"
  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tags", ["name"], :name => "index_tags_on_name"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "organization"
    t.string   "phone"
    t.text     "bio"
    t.string   "password_digest"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean  "admin",                  :default => false
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.string   "slug"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "membership"
    t.boolean  "verified"
    t.string   "verification_token"
    t.datetime "verification_sent_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "last_sign_in_at"
    t.string   "last_sign_in_ip"
    t.string   "continent"
    t.string   "account_type",           :default => "Researcher"
  end

  add_index "users", ["account_type"], :name => "index_users_on_account_type"
  add_index "users", ["continent"], :name => "index_users_on_continent"
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["id"], :name => "index_users_on_id"
  add_index "users", ["last_name"], :name => "index_users_on_last_name"
  add_index "users", ["slug"], :name => "index_users_on_slug", :unique => true

end
