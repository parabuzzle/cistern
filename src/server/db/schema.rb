# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090804022411) do

  create_table "agents", :force => true do |t|
    t.string   "name"
    t.string   "hostname"
    t.string   "port"
    t.string   "authkey"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "agents", ["hostname"], :name => "index_agents_on_hostname"
  add_index "agents", ["name"], :name => "index_agents_on_name"

  create_table "agents_logtypes", :force => true do |t|
    t.integer  "logtype_id"
    t.integer  "agent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "agents_logtypes", ["agent_id"], :name => "index_agents_logtypes_on_agent_id"
  add_index "agents_logtypes", ["logtype_id"], :name => "index_agents_logtypes_on_logtype_id"

  create_table "events", :force => true do |t|
    t.string   "payload"
    t.string   "staticentry_id"
    t.integer  "agent_id"
    t.integer  "loglevel_id"
    t.integer  "logtype_id"
    t.string   "etime"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["agent_id"], :name => "index_events_on_agent_id"
  add_index "events", ["etime"], :name => "index_events_on_etime"
  add_index "events", ["loglevel_id"], :name => "index_events_on_loglevel_id"
  add_index "events", ["logtype_id"], :name => "index_events_on_logtype_id"
  add_index "events", ["staticentry_id"], :name => "index_events_on_staticentry_id"

  create_table "loglevels", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logtypes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "logtypes", ["name"], :name => "index_logtypes_on_name"

  create_table "staticentries", :force => true do |t|
    t.integer  "logtype_id"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "staticentries", ["id"], :name => "index_staticentries_on_id"
  add_index "staticentries", ["logtype_id"], :name => "index_staticentries_on_logtype_id"

end
