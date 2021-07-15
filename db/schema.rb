# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_07_14_212330) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.string "uid"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "assignation_metrics", force: :cascade do |t|
    t.bigint "from", null: false
    t.bigint "github_user_id", null: false
    t.bigint "pull_request_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["github_user_id", "pull_request_id"], name: "index_metrics_on_ghuser_and_pr", unique: true
    t.index ["github_user_id"], name: "index_assignation_metrics_on_github_user_id"
    t.index ["pull_request_id"], name: "index_assignation_metrics_on_pull_request_id"
  end

  create_table "data_migrations", primary_key: "version", id: :string, force: :cascade do |t|
  end

  create_table "froggo_team_memberships", force: :cascade do |t|
    t.bigint "github_user_id", null: false
    t.bigint "froggo_team_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_member_active", default: true
    t.datetime "last_deactivation_date"
    t.datetime "last_activation_date"
    t.integer "assignment_percentage", default: 100
    t.index ["froggo_team_id"], name: "index_froggo_team_memberships_on_froggo_team_id"
    t.index ["github_user_id"], name: "index_froggo_team_memberships_on_github_user_id"
  end

  create_table "froggo_teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "organization_id"
    t.index ["organization_id"], name: "index_froggo_teams_on_organization_id"
  end

  create_table "github_users", force: :cascade do |t|
    t.string "avatar_url"
    t.string "email"
    t.integer "gh_id"
    t.string "html_url"
    t.string "login"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.index ["login"], name: "index_github_users_on_login"
  end

  create_table "hooks", force: :cascade do |t|
    t.string "hook_type"
    t.integer "gh_id"
    t.string "name"
    t.boolean "active"
    t.string "ping_url"
    t.string "test_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "resource_type"
    t.bigint "resource_id"
    t.index ["resource_type", "resource_id"], name: "index_hooks_on_resource_type_and_resource_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "github_user_id", null: false
    t.string "likeable_type", null: false
    t.bigint "likeable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["github_user_id"], name: "index_likes_on_github_user_id"
    t.index ["likeable_type", "likeable_id"], name: "index_likes_on_likeable_type_and_likeable_id"
  end

  create_table "organization_memberships", force: :cascade do |t|
    t.bigint "github_user_id"
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_member_of_default_team", default: false
    t.index ["github_user_id"], name: "index_organization_memberships_on_github_user_id"
    t.index ["organization_id"], name: "index_organization_memberships_on_organization_id"
  end

  create_table "organization_syncs", force: :cascade do |t|
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state"
    t.datetime "start_time"
    t.datetime "end_time"
    t.index ["organization_id"], name: "index_organization_syncs_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.integer "gh_id"
    t.string "login"
    t.string "description"
    t.string "html_url"
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.boolean "tracked"
    t.boolean "public_enabled"
    t.integer "default_team_id"
  end

  create_table "preferences", force: :cascade do |t|
    t.bigint "default_organization_id"
    t.bigint "default_team_id"
    t.bigint "default_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "github_user_id"
    t.index ["github_user_id"], name: "index_preferences_on_github_user_id"
  end

  create_table "pull_request_relations", force: :cascade do |t|
    t.bigint "pull_request_id"
    t.bigint "github_user_id"
    t.string "pr_relation_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "organization_id"
    t.integer "target_user_id"
    t.datetime "gh_updated_at"
    t.string "recommendation_behaviour", default: "not_defined"
    t.index ["gh_updated_at"], name: "index_pull_request_relations_on_gh_updated_at"
    t.index ["github_user_id"], name: "index_pull_request_relations_on_github_user_id"
    t.index ["organization_id", "gh_updated_at", "github_user_id", "pull_request_id"], name: "index_pr_relations_on_orgs_and_updated_and_user_and_prs"
    t.index ["organization_id", "gh_updated_at", "github_user_id", "target_user_id"], name: "index_pr_relations_on_orgs_and_updated_and_all_users"
    t.index ["organization_id"], name: "index_pull_request_relations_on_organization_id"
    t.index ["pull_request_id"], name: "index_pull_request_relations_on_pull_request_id"
    t.index ["target_user_id"], name: "index_pull_request_relations_on_target_user_id"
  end

  create_table "pull_request_review_requests", force: :cascade do |t|
    t.bigint "pull_request_id"
    t.bigint "github_user_id"
    t.integer "gh_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["github_user_id"], name: "index_pull_request_review_requests_on_github_user_id"
    t.index ["pull_request_id"], name: "index_pull_request_review_requests_on_pull_request_id"
  end

  create_table "pull_request_reviews", force: :cascade do |t|
    t.bigint "pull_request_id"
    t.bigint "github_user_id"
    t.integer "gh_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "recommendation_behaviour", default: "not_defined"
    t.datetime "approved_at"
    t.index ["github_user_id"], name: "index_pull_request_reviews_on_github_user_id"
    t.index ["pull_request_id"], name: "index_pull_request_reviews_on_pull_request_id"
  end

  create_table "pull_requests", force: :cascade do |t|
    t.integer "gh_id"
    t.string "title"
    t.integer "gh_number"
    t.string "pr_state"
    t.string "html_url"
    t.datetime "gh_created_at"
    t.datetime "gh_updated_at"
    t.datetime "gh_closed_at"
    t.datetime "gh_merged_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "repository_id"
    t.integer "owner_id"
    t.integer "merged_by_id"
    t.string "description"
    t.integer "commits"
    t.datetime "last_change"
    t.index ["repository_id"], name: "index_pull_requests_on_repository_id"
  end

  create_table "repositories", force: :cascade do |t|
    t.integer "gh_id"
    t.string "name"
    t.string "full_name"
    t.boolean "tracked", default: false
    t.string "url"
    t.string "html_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "organization_id"
    t.datetime "gh_updated_at"
    t.index ["organization_id"], name: "index_repositories_on_organization_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.string "taggable_type", null: false
    t.bigint "taggable_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "assignation_metrics", "github_users"
  add_foreign_key "assignation_metrics", "pull_requests"
  add_foreign_key "froggo_team_memberships", "froggo_teams"
  add_foreign_key "froggo_team_memberships", "github_users"
  add_foreign_key "likes", "github_users"
  add_foreign_key "organization_memberships", "github_users"
  add_foreign_key "organization_memberships", "organizations"
  add_foreign_key "organization_syncs", "organizations"
  add_foreign_key "preferences", "github_users"
  add_foreign_key "pull_request_relations", "github_users"
  add_foreign_key "pull_request_relations", "pull_requests"
  add_foreign_key "pull_request_review_requests", "github_users"
  add_foreign_key "pull_request_review_requests", "pull_requests"
  add_foreign_key "pull_request_reviews", "github_users"
  add_foreign_key "pull_request_reviews", "pull_requests"
  add_foreign_key "pull_requests", "github_users", column: "merged_by_id"
  add_foreign_key "pull_requests", "repositories"
  add_foreign_key "repositories", "organizations"
  add_foreign_key "taggings", "tags"
end
