class Api::V1::PreferencesController < Api::V1::BaseController
  def show
    authorize preference
    respond_with preference
  end

  def update
    authorize preference
    preference.update! update_params
    respond_with preference
  end

  private

  def preference
    @preference ||= Preference.find_or_create_by(github_user_id: github_user.id) do |preference|
      org_id = OrganizationMembership.find_by(github_user_id: github_user.id)&.organization_id
      team_id = FroggoTeamMembership.find_by(github_user_id: github_user.id)&.froggo_team_id
      preference.default_organization_id = org_id
      preference.default_team_id = team_id
      preference.default_time = 1
    end
  end

  def github_user
    @github_user ||= GithubUser.find_by(id: permitted_params[:id])
  end

  def permitted_params
    params.permit(:id)
  end

  def update_params
    params.permit(:default_organization_id, :default_team_id, :default_time)
  end

  def pundit_user
    github_session.user
  end
end
