# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_02_18_003953) do
  create_table "avaliacoes", force: :cascade do |t|
    t.string "nome"
    t.string "semestre"
    t.string "codigo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resposta", force: :cascade do |t|
    t.integer "avaliacao_id", null: false
    t.string "pergunta"
    t.string "resposta"
    t.string "usuario"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["avaliacao_id"], name: "index_resposta_on_avaliacao_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "course"
    t.string "matricula"
    t.string "usuario"
    t.string "formacao"
  end

  add_foreign_key "resposta", "avaliacaos"
end
