class GithubUser < ApplicationRecord
  has_many :pull_request_relations
  has_many :pull_request_review_requests, dependent: :nullify
  has_many :likes, dependent: :destroy
  has_many :pull_requests, foreign_key: :owner_id
  has_many :pull_request_reviews
  has_many :pull_requests_reviewed, through: :pull_request_reviews, source: :pull_request
  has_many :pull_requests_merged, class_name: 'PullRequest', foreign_key: :merged_by_id

  has_many :organization_memberships
  has_many :organizations, through: :organization_memberships, source: :organization

  has_many :froggo_team_memberships, dependent: :destroy
  has_many :froggo_teams, through: :froggo_team_memberships
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :assignation_metric, dependent: :destroy

  has_one :preference, dependent: :destroy

  validates :gh_id, presence: true
  validates :login, presence: true
  validates :description, length: { maximum: 255 }

  scope :all_except, ->(user) { where.not(id: user) }

  def get_froggo_teams_for_organization(organization)
    froggo_teams.filter { |team| team[:organization_id] == organization.id }
                .map do |team|
                  {
                    id: team.id,
                    name: team.name,
                    organization_id: organization[:id],
                    froggo_team: true
                  }
                end
  end

  def get_froggo_teams
    froggo_teams.map do |team|
      {
        id: team.id,
        name: team.name,
        organization_id: team.organization_id,
        froggo_team: true
      }
    end
  end

  def get_organizations_with_teams
    organizations.map do |organization|
      {
        id: organization.id,
        login: organization.login,
        teams: organization.get_froggo_teams
      }
    end
  end
end

# == Schema Information
#
# Table name: github_users
#
#  id          :bigint(8)        not null, primary key
#  avatar_url  :string
#  email       :string
#  gh_id       :integer
#  html_url    :string
#  login       :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :string
#
# Indexes
#
#  index_github_users_on_login  (login)
#
