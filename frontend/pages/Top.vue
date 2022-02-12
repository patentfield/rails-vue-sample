<style lang="scss" scoped>
@import "./PagesHome.scss";
</style>

<template lang="pug">
#index.ps-3(style="min-height:1000px;")
  h1 Index page
  div
    img(src='../images/front.png' width="80px")
    p This is sample for Rails 6.1 Webpack 4 Vue.js 2.6 VueRouter Vuex Vuetify Jest
    v-container Hello Vuetify world
  notification(v-if="showNotification")
  v-row(no-gutters class="mt-2")
    v-btn(color="info" @click="showNotification = !showNotification;") 通知設定
  v-row(no-gutters class="mt-5")
    v-col(cols="3")
      v-text-field(label="文字を入力してください" outlined v-model="searchWord")
  v-row(no-gutters class="mt-2")
    v-btn(color="error" @click="search();") 検索
  div(class="mt-3")
    router-link("to"="/") 検索結果
    router-link("to"="/page1" class="ml-2") Page1
    router-link("to"="/page2" class="ml-2") Page2
  div(class="mt-3 pl-3" v-if="$route.path !== '/'")
    router-view
  div(class="mt-3 pl-3" v-else)
    b ヒット件数:
    span.ml-2 {{nHits}}
    ul
      li(v-for="record in records")
        span {{record.applId}}
        span.ml-2 {{record.patentTitle}}
        span.ml-2 {{record.firstNamedApplicant.join(",")}}

</template>

<script>
import { mapGetters } from "vuex";
import SearchStore from '../store/SearchStore.js';
import Page1 from "./PagesHomePage1.vue";
import Page2 from "./PagesHomePage2.vue";
import Notification from '../components/Notification.vue';

var router = new VueRouter({
  routes: [
    { path: "/page1", component: Page1 },
    { path: "/page2", component: Page2 },
  ],
});

export default {
  router: router,
  store: SearchStore,
  components: {
    "notification": Notification
  },
  data: function () {
    return {
      showNotification: false,
      searchWord: ""
    }
  },
  computed: {
    ...mapGetters({
      nHits: "nHits",
      records: "records",
    }),
  },
  methods: {
    search () {
      SearchStore.dispatch('search', this.searchWord)
    }
  },
  mounted() {
    console.log("mounted vue");
  },
};
</script>
