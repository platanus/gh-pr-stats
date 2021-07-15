class AssignationMetric < ApplicationRecord
  belongs_to :github_user
  belongs_to :pull_request

  enum from: {
    desktop: 0,
    extension: 1
  }

  validates :from, presence: true
  validates :github_user_id, uniqueness: { scope: :pull_request_id }
end

# == Schema Information
#
# Table name: assignation_metrics
#
#  id              :bigint(8)        not null, primary key
#  from            :bigint(8)        not null
#  github_user_id  :bigint(8)        not null
#  pull_request_id :bigint(8)        not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_assignation_metrics_on_github_user_id   (github_user_id)
#  index_assignation_metrics_on_pull_request_id  (pull_request_id)
#  index_metrics_on_ghuser_and_pr                (github_user_id,pull_request_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (github_user_id => github_users.id)
#  fk_rails_...  (pull_request_id => pull_requests.id)
#
