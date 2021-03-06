import {
  PROFILE_TEAM_SELECTED,
  PROFILE_ORGANIZATION_SELECTED,
  RECOMMENDATIONS_FETCH_ERROR,
  RECOMMENDATIONS_RECEIVED,
  START_FETCHING_RECOMMENDATIONS,
  START_FETCHING_PR_INFORMATION,
  PROFILE_PR_INFORMATION_RECEIVED,
  PROFILE_PR_INFORMATION_FETCH_ERROR,
} from '../../mutation-types';

export default {
  [PROFILE_TEAM_SELECTED](state, { teamId, froggoTeam }) {
    state.selectedTeamId = teamId;
    state.isSelectedFroggoTeam = froggoTeam;
  },

  [PROFILE_ORGANIZATION_SELECTED](state, organizationId) {
    state.selectedOrganizationId = organizationId;
  },

  [START_FETCHING_RECOMMENDATIONS](state) {
    state.fetchingRecommendations = true;
  },

  [RECOMMENDATIONS_RECEIVED](state, recommendations) {
    state.recommendations = recommendations;
    state.fetchingRecommendations = false;
  },

  [RECOMMENDATIONS_FETCH_ERROR](state, error) {
    state.recommendationsError = error;
    state.fetchingRecommendations = false;
  },

  [START_FETCHING_PR_INFORMATION](state) {
    state.fetchingPullRequestInformation = true;
  },

  [PROFILE_PR_INFORMATION_RECEIVED](state, pullRequestData) {
    state.pullRequestInformation = pullRequestData.pullRequestsInformation;
    state.fetchingPullRequestInformation = false;
  },

  [PROFILE_PR_INFORMATION_FETCH_ERROR](state, error) {
    state.prInformationError = error;
    state.fetchingPullRequestInformation = false;
  },
};
