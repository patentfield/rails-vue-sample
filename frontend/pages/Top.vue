<style lang="scss" scoped>
@import "./PagesHome.scss";
</style>

<template lang="pug">
#index.ps-3(style="min-height:1000px;")
  h1 Index page
  div
    img(src='../images/front.png' width="80px")
    p This is sample for Rails 7.0 Webpack 4 Vue.js 2.6 VueRouter Vuex Vuetify Jest
    v-container Hello Vuetify world
  notification(v-if="showNotification")
  v-row(no-gutters class="mt-2")
    v-btn(color="info" @click="showNotification = !showNotification;") 通知設定
  v-row(no-gutters class="mt-5")
    v-col(cols="3")
      v-text-field(label="文字を入力してください" outlined v-model="searchWord")
    v-col(cols="9")
      span.ml-2 スペースORスペース区切りでOR検索が可能。検索結果シートの検索ワード選択肢で切り替え。Page3シートでグラフ表示。
  v-row(no-gutters class="mt-2")
    v-btn(color="error" @click="search();") 検索
  div(class="mt-3 pl-3" v-if="histories.length > 0")
    b 検索履歴:
    ul
      li(v-for="history in histories")
        span
          v-btn(color="warning" @click="destroyId = history.id; destroy();") 削除
        span.ml-2 {{history.search_word}}
  div(class="mt-3")
    router-link("to"="/") 検索結果
    router-link("to"="/page1" class="ml-2") Page1
    router-link("to"="/page2" class="ml-2") Page2
    router-link("to"="/page3" class="ml-2") Page3
  div(class="mt-3 pl-3" v-if="$route.path !== '/'")
    router-view
  div(class="mt-3 pl-3" v-else)
    div(v-if="responses.length > 0")
      b 検索ワード:
      span.ml-2
        select(v-model="selected")
          option(v-for="(word, index) in trace.x" :value="index") {{word}}
    b ヒット件数:
    span.ml-2(v-if="responses.length > 0") {{responses[selected]["numFound"]}}
    span.ml-2(v-else) 0
    ul(v-if="responses.length > 0")
      li(v-for="record in responses[selected].docs")
        span {{record.applId}}
        span.ml-2 {{record.patentTitle}}
        span.ml-2 {{record.firstNamedApplicant.join(",")}}

</template>

<script>
import { mapGetters } from "vuex";
import SearchStore from '../store/SearchStore.js';
import Page1 from "./PagesHomePage1.vue";
import Page2 from "./PagesHomePage2.vue";
import Page3 from "./PagesHomePage3.vue";
import Notification from '../components/molecules/Notification.vue';

var router = new VueRouter({
  routes: [
    { path: "/page1", component: Page1 },
    { path: "/page2", component: Page2 },
    { path: "/page3", component: Page3 },
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
      searchWord: "",
      selected: 0,
      destroyId: 0
    }
  },
  computed: {
    ...mapGetters({
      responses: "responses",
      histories: "histories",
      trace: "trace",
    }),
  },
  methods: {
    search () {
      SearchStore.dispatch('search', this.searchWord)
    },
    index () {
      SearchStore.dispatch('index')
    },
    destroy () {
      SearchStore.dispatch('destroy', this.destroyId)
    },
  },
  created() {
    console.log("created vue");
    this.index();
  },
  mounted() {
    console.log("mounted vue");
  },
};
</script>
