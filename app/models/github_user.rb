class GithubUser < ApplicationRecord
  has_many :pull_request_relations

  has_many :pull_requests, foreign_key: :owner_id
  has_many :pull_request_reviews
  has_many :pull_requests_reviewed, through: :pull_request_reviews, source: :pull_request
  has_many :pull_requests_merged, class_name: 'PullRequest', foreign_key: :merged_by_id

  validates :gh_id, presence: true
  validates :login, presence: true

  scope :tracked, -> { where(tracked: true) }
end

# == Schema Information
#
# Table name: github_users
#
#  id         :integer          not null, primary key
#  avatar_url :string
#  email      :string
#  gh_id      :integer
#  html_url   :string
#  login      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tracked    :boolean
#
# Indexes
#
#  index_github_users_on_login  (login)
#
