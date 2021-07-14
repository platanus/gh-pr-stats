class Api::V1::PreferenceSerializer < ActiveModel::Serializer
  attributes :github_user_id, :default_org, :default_team, :default_time

  def default_org
    organization = Organization.find_by(id: object.default_organization_id)
    Api::V1::OrganizationSerializer.new(organization) if organization
  end

  def default_team
    froggo_team = FroggoTeam.find_by(id: object.default_team_id)
    Api::V1::FroggoTeamSerializer.new(froggo_team) if froggo_team
  end
end
