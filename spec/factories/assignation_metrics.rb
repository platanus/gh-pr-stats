FactoryBot.define do
  factory :assignation_metric do
    association :github_user
    association :pull_request

    from { :desktop }
  end
end
