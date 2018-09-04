require 'rails_helper'

RSpec.describe GithubAuthController, type: :controller do
  describe 'GET #callback' do
    let(:github_return_code) { 'github_code' }
    let(:token_result) { { access_token: 'token' } }
    let!(:github_session) { double(name: 'name') }

    before do
      expect(Octokit).to receive(:exchange_code_for_token)
        .with(github_return_code, ENV['GH_AUTH_ID'], ENV['GH_AUTH_SECRET'])
        .and_return(token_result)
      allow(subject).to receive(:github_session)
        .and_return(github_session)
    end

    context 'from home' do
      before do
        get :callback, params: { client_type: :member, code: github_return_code }
      end

      it 'sets session values correctly' do
        expect(cookies["access_token"]).to eq(token_result[:access_token])
        expect(cookies["client_type"]).to eq('member')
      end
    end

    context 'from home without last path in cookies' do
      before do
        get :callback, params: { client_type: :member, code: github_return_code }
      end

      it { expect(response).to redirect_to(organizations_path) }
    end

    context 'from home with last path in cookies' do
      before do
        cookies["froggo_#{github_session.name}_path"] = organization_path(name: 'org')
        get :callback, params: { client_type: :member, code: github_return_code }
      end

      it {
        expect(response).to redirect_to(cookies["froggo_#{github_session.name}_path"])
      }
    end

    context 'from dashboard settings of organization' do
      let(:gh_org) { 'test_org' }
      before do
        get :callback, params: { client_type: :member,
                                 code: github_return_code,
                                 callback_action: 'settings',
                                 gh_org: gh_org }
      end

      it { expect(response).to redirect_to(settings_organization_path(name: gh_org)) }
    end
  end
end
