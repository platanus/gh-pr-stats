FactoryBot.define do
  factory :pull_request_relation do
    pr_relation_type :assignee
    association :pull_request
    association :github_user
  end
end