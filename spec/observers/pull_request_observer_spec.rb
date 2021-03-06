require 'rails_helper'

describe PullRequestObserver, observers: true do
  describe "#update_pull_request_relations" do
    let(:pull_request) { create(:pull_request) }
    before do
      expect_any_instance_of(PullRequestRelationService).to receive(:create_merge_relation)
        .and_return(nil)
    end

    it "calls service to create merge relation" do
      pull_request.update(merged_by: create(:github_user), gh_merged_at: Time.current)
    end
  end

  describe "#destroy_pull_request_relations" do
    let(:pull_request) { create(:pull_request) }
    before do
      create(:pull_request_relation, pull_request: pull_request)
    end

    it "destroy all pull request relations" do
      pull_request.destroy
      expect(PullRequestRelation.by_pull_request(pull_request.id)).to be_empty
    end
  end
end
