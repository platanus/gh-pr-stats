class PullRequest < ApplicationRecord
  include PowerTypes::Observable

  belongs_to :repository
  belongs_to :owner, class_name: 'GithubUser'
  belongs_to :merged_by, class_name: 'GithubUser', optional: true

  has_many :likes, as: :likeable, dependent: :destroy, inverse_of: :likeable
  has_many :pull_request_reviews, dependent: :destroy
  has_many :pull_request_reviewers, through: :pull_request_reviews, source: :github_user

  has_many :pull_request_relations, dependent: :destroy
  has_many :pull_request_review_requests, dependent: :destroy

  has_many :assignation_metric, dependent: :destroy

  scope :within_month_limit, -> do
    where('pull_requests.gh_updated_at > ?',
          Time.current - ENV['PULL_REQUEST_MONTH_LIMIT'].to_i.months)
  end

  scope :open, -> do
    where(pr_state: 'open')
  end

  scope :by_organizations, ->(organization_ids) do
    joins(:repository).where(repositories: { organization_id: organization_ids })
  end

  scope :by_repository, ->(repository) do
    if repository.present?
      joins(:repository).where("LOWER(repositories.name) LIKE LOWER(?)", "%#{repository}%")
    end
  end

  scope :by_owner, ->(owner) do
    if owner.present?
      joins(:owner).where("LOWER(github_users.login) LIKE LOWER(?)", "%#{owner}%")
    end
  end

  scope :by_start_date, ->(date) do
    if date.present?
      joins(:owner).where("pull_requests.created_at >= ?", "%#{date}%")
    end
  end

  scope :by_end_date, ->(date) do
    if date.present?
      joins(:owner).where("pull_requests.created_at <= ?", "%#{date}%")
    end
  end

  scope :by_title, ->(title) do
    if title.present?
      joins(:owner).where("LOWER(pull_requests.title) LIKE LOWER(?)", "%#{title}%")
    end
  end

  scope :by_top_liked, -> do
    joins(:likes)
      .select('pull_requests.*, count(likes) as like_count')
      .group('pull_requests.id')
      .order("like_count desc")
  end

  validates :gh_id, presence: true
  validates :pr_state, presence: true, inclusion: { in: %w(open closed) }

  delegate :name, to: :repository, prefix: true, allow_nil: true
  delegate :name, to: :owner, prefix: true, allow_nil: true
  delegate :login, to: :owner, prefix: true, allow_nil: true
end

# == Schema Information
#
# Table name: pull_requests
#
#  id            :bigint(8)        not null, primary key
#  gh_id         :integer
#  title         :string
#  gh_number     :integer
#  pr_state      :string
#  html_url      :string
#  gh_created_at :datetime
#  gh_updated_at :datetime
#  gh_closed_at  :datetime
#  gh_merged_at  :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  repository_id :bigint(8)
#  owner_id      :integer
#  merged_by_id  :integer
#  last_change   :datetime
#  description   :string
#  commits       :integer
#
# Indexes
#
#  index_pull_requests_on_repository_id  (repository_id)
#
# Foreign Keys
#
#  fk_rails_...  (merged_by_id => github_users.id)
#  fk_rails_...  (repository_id => repositories.id)
#
