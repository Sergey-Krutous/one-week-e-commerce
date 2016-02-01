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

ActiveRecord::Schema.define(version: 20160201072355) do

  create_table "addresses", force: :cascade do |t|
    t.string   "email",          limit: 254, null: false
    t.string   "first_name",     limit: 100, null: false
    t.string   "last_name",      limit: 100, null: false
    t.string   "country",        limit: 50,  null: false
    t.string   "state",          limit: 50
    t.string   "city",           limit: 100, null: false
    t.string   "street_address", limit: 100, null: false
    t.string   "zip",            limit: 10
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "title",      limit: 100,             null: false
    t.string   "slug",       limit: 100
    t.integer  "parent_id"
    t.integer  "lft",                    default: 0, null: false
    t.integer  "rgt",                    default: 0, null: false
    t.integer  "depth",                  default: 0, null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "categories", ["lft"], name: "index_categories_on_lft"
  add_index "categories", ["parent_id"], name: "index_categories_on_parent_id"
  add_index "categories", ["rgt"], name: "index_categories_on_rgt"

  create_table "categories_products", id: false, force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "product_id",  null: false
  end

  add_index "categories_products", ["category_id"], name: "index_categories_products_on_category_id"
  add_index "categories_products", ["product_id"], name: "index_categories_products_on_product_id"

  create_table "images", force: :cascade do |t|
    t.integer  "product_id", null: false
    t.string   "file",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "images", ["product_id"], name: "index_images_on_product_id"

  create_table "order_lines", force: :cascade do |t|
    t.integer  "order_id",   null: false
    t.integer  "product_id", null: false
    t.decimal  "price",      null: false
    t.integer  "quantity",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "order_lines", ["order_id"], name: "index_order_lines_on_order_id"
  add_index "order_lines", ["product_id"], name: "index_order_lines_on_product_id"

  create_table "orders", force: :cascade do |t|
    t.date     "date",                null: false
    t.integer  "billing_address_id",  null: false
    t.integer  "shipping_address_id", null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "orders", ["billing_address_id"], name: "index_orders_on_billing_address_id"
  add_index "orders", ["shipping_address_id"], name: "index_orders_on_shipping_address_id"

  create_table "products", force: :cascade do |t|
    t.string   "title",       limit: 100
    t.string   "slug",        limit: 100
    t.string   "description", limit: 500
    t.decimal  "price"
    t.integer  "quantity"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

end
