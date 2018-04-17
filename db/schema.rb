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

ActiveRecord::Schema.define(version: 20180417181305) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "book_suggestions", force: :cascade do |t|
    t.string   "book_name"
    t.string   "author_name"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.string   "sub_title"
    t.string   "statement_resource"
    t.string   "author"
    t.string   "sub_author"
    t.string   "book_type"
    t.integer  "account_no"
    t.float    "price"
    t.date     "entry_date"
    t.float    "ddc_no"
    t.string   "auth_mark"
    t.string   "section"
    t.boolean  "book_reference"
    t.string   "book_publisher"
    t.string   "place"
    t.integer  "book_year"
    t.string   "book_source"
    t.string   "book_edition"
    t.string   "book_volume"
    t.integer  "book_pages"
    t.string   "series"
    t.string   "language"
    t.string   "isbn"
    t.string   "binding"
    t.string   "cd_flopy"
    t.string   "status"
    t.string   "remarks"
    t.string   "content"
    t.string   "notes"
    t.string   "subject"
    t.string   "keyword"
    t.string   "suggested_by"
    t.string   "discipline"
    t.string   "shipping_charges"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "patrons", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "type"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.string   "invited_by_type"
    t.integer  "invited_by_id"
    t.integer  "invitations_count",      default: 0
    t.string   "username"
    t.index ["confirmation_token"], name: "index_patrons_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_patrons_on_email", unique: true, using: :btree
    t.index ["invitation_token"], name: "index_patrons_on_invitation_token", unique: true, using: :btree
    t.index ["invitations_count"], name: "index_patrons_on_invitations_count", using: :btree
    t.index ["invited_by_id"], name: "index_patrons_on_invited_by_id", using: :btree
    t.index ["reset_password_token"], name: "index_patrons_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_patrons_on_username", unique: true, using: :btree
  end

  create_table "reserve_books", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.boolean  "status",     default: false
    t.date     "issue_date"
    t.date     "due_date"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

end
