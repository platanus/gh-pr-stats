require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
  before do
    expect(subject).to receive(:authenticate_github_user).and_return(true)
    allow(subject).to receive(:github_session).and_return(github_session)
  end

  let(:github_organizations) do
    [
      { id: 101, login: 'platanus' },
      { id: 102, login: 'huevapi' }
    ]
  end

  describe "GET #index" do
    context "when ser does not belongs to any organizations" do
      let(:github_session) { double(organizations: []) }

      before do
        get :index
      end

      it { expect(response).to redirect_to('/organizations/missing') }
    end

    context "when user belongs to at least one organization, but no organization is selected" do
      let(:github_session) { double(organizations: github_organizations) }

      before do
        get :index
      end

      it 'redirects to first organization' do
        expect(response).to redirect_to('/organizations/platanus')
      end
    end
  end

  describe "#show" do
    let(:github_session) { double(organizations: github_organizations) }

    context "when user belongs the selected organization" do
      before do
        get :show, params: { name: "platanus" }
      end

      it { expect(assigns(:github_organization)).to eq(github_organizations.first) }
    end

    context "when user does not belong to the selected organization" do
      before do
        get :show, params: { name: "tesla" }
      end

      it { expect(response).to redirect_to('/organizations') }
    end

    context "when organization exists locally" do
      let!(:organization) { create(:organization, gh_id: 101) }

      before do
        get :show, params: { name: "platanus" }
      end

      it { expect(assigns(:organization)).to eq(organization) }
      it { expect(assigns(:has_dashboard)).to be_truthy }
    end

    context "when organization does not exist locally" do
      before do
        get :show, params: { name: "platanus" }
      end

      it { expect(assigns(:organization)).to be_nil }
      it { expect(assigns(:has_dashboard)).to be_falsey }
    end
  end

  describe "GET #settings" do
    let(:github_session) do
      double(
        session: { client_type: "admin" },
        organizations: [login: "platanus", role: role]
      )
    end

    before do
      get :settings, params: { name: "platanus" }
    end

    context "when user is admin" do
      let(:role) { "admin" }

      it { expect(response).to have_http_status(200) }
    end

    context "when user is admin" do
      let(:role) { "member" }

      it { expect(response).to redirect_to('/organizations/platanus') }
    end
  end
end