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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150809022253) do

  create_table "products", force: :cascade, :id => false do |t|
    t.integer   "pid", :primary_key => true
    t.string    "name"
    t.text      "description"
    t.integer   "price"
    t.integer   "stock_count"
    t.integer   "company_id"
    t.string    "image_url"
    t.string    "barcode"
  end
  create_table "companies", force: :cascade, :id => false do |t|
    t.integer   "company_id", :primary_key => true
    t.text      "name"
    t.string    "description", :limit => 50
    t.text      "address"
    t.text      "image_url"
    t.text      "email"
    t.boolean   "approved"
    t.text      "username"
    t.text      "password"
  end

  add_index :companies, :username, unique: true
  change_column_null :companies, :name, false

  create_table "stories", force: :cascade do |t|
    t.integer   "company_id"
    t.string    "title"
    t.text      "description"
    t.string    "image"
  end
  create_table "users", force: :cascade do |t|
    t.string    "username"
    t.string    "fname"
    t.string    "lname"
    t.string    "password"
    t.string    "email"
  end

  add_index :users, :username, unique: true

  create_table "carts", force: :cascade do |t|
    t.integer   "user_id"
    t.text      "products"
    t.text      "wishlist"
  end

  create_table "likes", force: :cascade do |t|
    t.integer   "user_id"
    t.text      "likedlist"
  end

  create_table "posts", force: :cascade do |t|
    t.integer   "user_id"
    t.text      "title"
    t.text      "message"
    t.text      "image"
  end
end
