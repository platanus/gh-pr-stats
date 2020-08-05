class OrganizationsController < ApplicationController
  before_action :authenticate_github_user, except: [:public]
  before_action :save_cookie_url
  before_action :load_organization, except: [:index, :missing, :public]
  before_action :load_organization_by_name, only: [:public]
  before_action :ensure_organization_admin, only: :settings

  def index
    if github_organizations.empty?
      redirect_to missing_organizations_path
    else
      redirect_to_default_organization
    end
  end

  def show
    @is_admin = organization_admin?
    @organizations = github_organizations
    set_corrmat
    @color_scores = get_color_scores
  end

  def create
    CreateOrganization.for(token: @github_session.token, github_organization: @github_organization)
    redirect_to settings_organization_path(name: @github_organization[:login])
  end

  def missing; end

  def settings
    @is_admin_github_session = github_session.session[:client_type] == "admin"
    if @has_dashboard && @organization.default_team_id.present?
      load_behaviour_matrix_params
      if @default_team_members_ids
        set_behaviour_matrix
      end
    end
  end

  def public
    if @organization.public_enabled
      set_corrmat
      @public_mode = true
    else
      redirect_to organization_path(@organization)
    end
  end

  private

  def load_organization
    @github_organization = github_organizations.find do |org|
      org[:login] == permitted_params[:name]
    end
    if @github_organization.nil?
      redirect_to '/organizations'
    else
      @organization = Organization.find_by(gh_id: @github_organization[:id])
      @has_dashboard = !@organization.nil?
      load_matrix_params if @has_dashboard
    end
  end

  def load_organization_by_name
    @organization = Organization.find_by(login: permitted_params[:name])
    @has_dashboard = !@organization.nil?
    load_public_matrix_params if @has_dashboard
  end

  def load_matrix_params
    @teams = github_teams
    if permitted_params[:team]
      @team = @teams.find { |team| team[:slug] == permitted_params[:team] }
      @team_members_ids = github_team_members&.pluck(:id)
    end
    if permitted_params[:month_limit].present?
      @month_limit = permitted_params[:month_limit].to_i
    end
  end

  def load_behaviour_matrix_params
    @teams = github_teams
    if @organization.default_team_id
      @team = @teams.find { |team| team[:id] == @organization.default_team_id }
      @default_team_members_ids = github_team_members&.pluck(:id)
    end
  end

  def load_public_matrix_params
    @team_members_ids = permitted_params[:user_ids]
    if permitted_params[:month_limit].present?
      @month_limit = permitted_params[:month_limit].to_i
    end
  end

  def set_corrmat
    if @has_dashboard
      @corrmat = get_matrix(@organization.id, @team_members_ids, @month_limit)
    end
  end

  def set_behaviour_matrix
    @behaviour_matrix = get_behaviour_matrix(@organization.id, @default_team_members_ids)
  end

  def redirect_to_default_organization
    redirect_to organization_path(name: github_session.organizations.first[:login])
  end

  def github_organizations
    github_session.organizations
  end

  def github_teams
    github_session.get_teams(@organization)
  end

  def github_team_members
    github_session.get_team_members(@team[:id])
  end

  def ensure_organization_admin
    redirect_to organization_path(name: @github_organization[:login]) unless organization_admin?
  end

  def organization_admin?
    @github_organization[:role] == "admin"
  end

  def permitted_params
    params.permit(:name, :team, :month_limit, user_ids: [])
  end

  def get_matrix(org_id, user_ids, month_limit)
    corrmat = CorrelationMatrix.new(org_id, user_ids, github_user.login, month_limit)
    corrmat.fill_matrix
    corrmat.min_ranking_indexes
    corrmat
  end

  def get_behaviour_matrix(organization_id, default_team_members_ids)
    behaviour_matrix = RecommendationBehaviourMatrix.new(organization_id, default_team_members_ids)
    behaviour_matrix.fill_matrix
    behaviour_matrix
  end

  def save_cookie_url
    github_session.save_froggo_path(request.fullpath)
  end

  def get_color_scores
    return unless @has_dashboard

    ComputeColorScore.for(
      user_id: github_user.id, other_users_ids: get_other_users_ids,
      pr_relations: get_pr_relations, review_month_limit: @month_limit
    )
  end

  def get_other_users_ids
    return GithubUser.where(gh_id: @team_members_ids).map(&:id) if @team_members_ids

    @organization.members.map(&:id)
  end

  def get_pr_relations
    return PullRequestRelation.by_organizations(@organization.id) unless @month_limit

    PullRequestRelation.by_organizations(@organization.id).within_month_limit(@month_limit)
  end
end
