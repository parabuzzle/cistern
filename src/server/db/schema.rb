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

ActiveRecord::Schema.define(:version => 20090730154024) do

  create_table "agents", :force => true do |t|
    t.string   "name"
    t.string   "hostname"
    t.string   "port"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "agents_logtypes", :force => true do |t|
    t.integer  "logtype_id"
    t.integer  "agent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "payload"
    t.string   "staticentry_id"
    t.integer  "agent_id"
    t.integer  "type_id"
    t.integer  "loglevel"
    t.integer  "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logtypes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staticentries", :force => true do |t|
    t.integer  "logtype_id"
    t.text     "data"
    t.integer  "agent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
