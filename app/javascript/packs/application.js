/* eslint no-console: 0 */
/* global document, window */

import Vue from 'vue/dist/vue.esm';
import VueI18n from 'vue-i18n';

import Dropdown from '../components/pl-dropdown.vue';
import TeamsDropdown from '../components/teams-dropdown.vue';
import OrganizationsDropdown from '../components/organizations-dropdown.vue';
import Repository from '../components/repository.vue';
import EnablePublicButton from '../components/enable-public-button.vue';
import SyncOrganizationButton from '../components/sync-organization-button.vue';
import DashboardSyncingIcon from '../components/dashboard-syncing-icon.vue';
import PublicDashboardCarousel from '../components/public-dashboard/carousel.vue';
import ProfileRecommendations from '../components/profile/recommendations.vue';
import ProfileRecommendationsUsers from '../components/profile/recommendations-users.vue';
import ProfileStatistics from '../components/profile/statistics.vue';

import Locales from '../locales.js';
import store from '../store';

Vue.use(VueI18n);

document.addEventListener('DOMContentLoaded', () => {
  Vue.component('repository', Repository);
  Vue.component('enable-public-button', EnablePublicButton);
  Vue.component('dropdown', Dropdown);
  Vue.component('teams-dropdown', TeamsDropdown);
  Vue.component('organizations-dropdown', OrganizationsDropdown);
  Vue.component('sync-organization-button', SyncOrganizationButton);
  Vue.component('dashboard-syncing-icon', DashboardSyncingIcon);
  Vue.component('public-dashboard-carousel', PublicDashboardCarousel);
  Vue.component('profile-recommendations', ProfileRecommendations);
  Vue.component('profile-recommendations-users', ProfileRecommendationsUsers);
  Vue.component('profile-statistics', ProfileStatistics);

  if (document.getElementById('app') !== null) {
    new Vue({ // eslint-disable-line no-new
      el: '#app',
      i18n: new VueI18n({
        locale: 'es',
        messages: Locales.messages,
      }),
      store,
      data: {
        activeOrg: null,
      },
      methods: {
        changeOrganization(organization) {
          if (organization === null) {
            return;
          }
          if (this.activeOrg !== organization.login) {
            document.location.href = `/organizations/${organization.login}`;
          }

          return;
        },
      },
      beforeMount() {
        const pathArray = window.location.pathname.split('/');
        const orgNameUrlPos = 1;
        if (pathArray.length > orgNameUrlPos + 1 && pathArray[orgNameUrlPos] === 'organizations') {
          this.activeOrg = pathArray[orgNameUrlPos + 1];
        }
      },
    });
  }
});
