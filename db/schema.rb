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

ActiveRecord::Schema.define(:version => 20140128155930) do

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
    t.string   "ancestry"
  end

  add_index "comments", ["ancestry"], :name => "index_comments_on_ancestry"
  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "connection_requests", :force => true do |t|
    t.integer  "sender_id",                            :null => false
    t.integer  "receiver_id",                          :null => false
    t.datetime "new_connection_request_email_sent_at"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "connection_token"
  end

  add_index "connection_requests", ["receiver_id"], :name => "index_connection_requests_on_receiver_id"
  add_index "connection_requests", ["sender_id"], :name => "index_connection_requests_on_sender_id"

  create_table "connections", :force => true do |t|
    t.integer  "connecter_id"
    t.integer  "connected_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "connections", ["connected_id"], :name => "index_connections_on_connected_id"
  add_index "connections", ["connecter_id", "connected_id"], :name => "index_connections_on_connecter_id_and_connected_id", :unique => true
  add_index "connections", ["connecter_id"], :name => "index_connections_on_connecter_id"

  create_table "contacts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "user_type",  :default => "Researcher"
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.string   "website"
    t.text     "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "twitter_handle"
    t.string   "location_name"
    t.string   "organizer"
    t.string   "phone"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "slug"
    t.string   "bitly_url"
    t.integer  "user_id"
    t.integer  "view_count",     :default => 0
    t.boolean  "approved",       :default => false
  end

  add_index "events", ["slug"], :name => "index_events_on_slug"
  add_index "events", ["user_id"], :name => "index_events_on_user_id"

  create_table "facilities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "website"
    t.string   "email"
    t.string   "phone"
    t.string   "slug"
  end

  add_index "facilities", ["name"], :name => "index_facilities_on_name"
  add_index "facilities", ["slug"], :name => "index_facilities_on_slug"

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
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "must_have",     :default => true
    t.string   "resource_type"
  end

  add_index "instruments", ["alias"], :name => "index_instruments_on_name"
  add_index "instruments", ["project_id"], :name => "index_instruments_on_project_id"
  add_index "instruments", ["resource_type"], :name => "index_instruments_on_resource_type"

  create_table "invitations", :force => true do |t|
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "message"
  end

  add_index "invitations", ["email"], :name => "index_invitations_on_email"
  add_index "invitations", ["user_id"], :name => "index_invitations_on_user_id"

  create_table "labs", :force => true do |t|
    t.string   "name"
    t.integer  "facility_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "labs", ["facility_id"], :name => "index_labs_on_facility_id"
  add_index "labs", ["name"], :name => "index_labs_on_name"

  create_table "leads", :force => true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "full_name"
    t.string   "organization"
    t.string   "department"
    t.string   "country"
    t.string   "phone"
    t.string   "account_type"
    t.text     "notes"
    t.string   "title"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "leads", ["country"], :name => "index_leads_on_country"
  add_index "leads", ["email"], :name => "index_leads_on_email"
  add_index "leads", ["last_name"], :name => "index_leads_on_last_name"

  create_table "likes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "likeable_id"
    t.string   "likeable_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "likes", ["likeable_id", "likeable_type"], :name => "index_likes_on_likeable_id_and_likeable_type"
  add_index "likes", ["user_id"], :name => "index_likes_on_user_id"

  create_table "locations", :force => true do |t|
    t.string   "address1"
    t.string   "address2"
    t.string   "address3"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "locationable_id"
    t.string   "locationable_type"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.boolean  "display_on_map",    :default => true
  end

  add_index "locations", ["locationable_id", "locationable_type"], :name => "index_locations_on_locationable_id_and_locationable_type"

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
    t.string   "protocol"
    t.integer  "user_id"
    t.string   "service_need"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.date     "start_date"
    t.string   "slug"
    t.integer  "view_count",      :default => 0
    t.string   "visability",      :default => "public"
    t.boolean  "searchable",      :default => true
    t.boolean  "active",          :default => false
    t.date     "expiration_date"
    t.string   "bitly_url"
  end

  add_index "projects", ["active"], :name => "index_projects_on_active"
  add_index "projects", ["protocol"], :name => "index_projects_on_protocol"
  add_index "projects", ["searchable"], :name => "index_projects_on_searchable"
  add_index "projects", ["service_need"], :name => "index_projects_on_service_need"
  add_index "projects", ["slug"], :name => "index_projects_on_slug"
  add_index "projects", ["user_id"], :name => "index_projects_on_user_id"
  add_index "projects", ["visability"], :name => "index_projects_on_visability"

  create_table "resources", :force => true do |t|
    t.string   "name"
    t.string   "kind"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.text     "note"
    t.integer  "service_id"
    t.integer  "quantity",      :default => 1
    t.integer  "price"
    t.string   "unit_type"
    t.string   "currency_type"
  end

  add_index "resources", ["kind"], :name => "index_resources_on_kind"
  add_index "resources", ["name"], :name => "index_resources_on_name"

  create_table "services", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "slug"
    t.integer  "view_count",      :default => 0
    t.string   "bitly_url"
    t.string   "visability",      :default => "public"
    t.boolean  "searchable",      :default => true
    t.boolean  "active",          :default => true
    t.date     "expiration_date"
  end

  add_index "services", ["name"], :name => "index_services_on_name"
  add_index "services", ["searchable"], :name => "index_services_on_searchable"
  add_index "services", ["slug"], :name => "index_services_on_slug"
  add_index "services", ["user_id"], :name => "index_services_on_user_id"
  add_index "services", ["visability"], :name => "index_services_on_visability"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "taggable_id"
    t.string   "taggable_type"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

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
    t.string   "phone"
    t.text     "bio",                    :default => ""
    t.string   "password_digest"
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean  "admin",                  :default => false
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.string   "slug"
    t.string   "country"
    t.string   "membership",             :default => "basic"
    t.boolean  "verified"
    t.string   "verification_token"
    t.datetime "verification_sent_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "last_sign_in_at"
    t.string   "last_sign_in_ip"
    t.string   "continent"
    t.string   "account_type",           :default => "Researcher"
    t.string   "organization"
    t.integer  "facility_id"
    t.integer  "lab_id"
    t.string   "invite_token"
    t.integer  "referrer_id"
    t.boolean  "project_alerts",         :default => false
    t.boolean  "blog_alerts",            :default => false
    t.boolean  "event_alerts",           :default => false
    t.boolean  "subscribed",             :default => true
    t.boolean  "newsletter",             :default => true
    t.string   "title"
    t.string   "tw_url"
    t.string   "li_url"
    t.string   "mend_url"
    t.string   "fb_url"
    t.string   "website"
    t.text     "interest_description"
  end

  add_index "users", ["account_type"], :name => "index_users_on_account_type"
  add_index "users", ["continent"], :name => "index_users_on_continent"
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["id"], :name => "index_users_on_id"
  add_index "users", ["invite_token"], :name => "index_users_on_invite_token"
  add_index "users", ["last_name"], :name => "index_users_on_last_name"
  add_index "users", ["referrer_id"], :name => "index_users_on_referrer_id"
  add_index "users", ["slug"], :name => "index_users_on_slug", :unique => true

end
