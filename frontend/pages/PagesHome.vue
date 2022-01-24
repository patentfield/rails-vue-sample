<style lang="scss" scoped>
@import "./PagesHome.scss";
</style>

<template lang="pug">
#app
  #index
    v-app
      v-main(class="ps-3")
        h1 Index page
        div
          img(src='../images/front.png' width="80px")
          p This is sample for Rails 6.1 Webpack 4 Vue.js 2.6 VueRouter Vuex Vuetify Jest
          v-container Hello Vuetify world
        v-row(no-gutters)
          v-col(cols="12")
            v-btn(color="secondary" @click="subscribeNotifications();") RailsのNotificationsチャンネルを購読する
            div チャンネル接続ステータス: {{channelStatus}}
            div チャンネルメッセージ: {{channelMessage}}
        v-row(no-gutters class="mt-2")
          v-col(cols="12")
            v-btn(color="warning" @click="sendNotifications();") RailsのNotificationsチャンネルに通知する
        v-row(no-gutters class="mt-2")
          v-col(cols="12")
            v-btn(color="info" @click="startBatch();") Railsでバッチ処理を開始する
        v-row(no-gutters class="mt-2")
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

var router = new VueRouter({
  routes: [
    { path: "/page1", component: Page1 },
    { path: "/page2", component: Page2 },
  ],
});

export default {
  vuetify: new Vuetify(),
  router: router,
  store: SearchStore,
  data: function () {
    return {
      channelStatus: null,
      channelMessage: null,
      searchWord: ""
    }
  },
  channels: {
    NotificationsChannel: {
      connected() {
        this.channelStatus = "connected"
      },
      rejected() {
        this.channelStatus = "rejected"
      },
      received(data) {
        this.channelStatus = "received"
        this.channelMessage = data
      },
      disconnected() {
        this.channelStatus = "disconnected"
      }
    }
  },
  computed: {
    ...mapGetters({
      nHits: "nHits",
      records: "records",
    }),
  },
  methods: {
    subscribeNotifications () {
      if (this.$cable) {
        this.$cable.unsubscribe('NotificationsChannel')
        this.$cable.connection.disconnect()
      }
      this.$cable._cable = null
      this.$cable.connection.connect(`ws://localhost:3000/cable`);
      this.$cable.subscribe({ channel: 'NotificationsChannel' })
    },
    sendNotifications () {
      console.log("send notifications");
      axios.defaults.headers['X-CSRF-TOKEN'] = document.getElementsByName('csrf-token')[0].getAttribute('content')
      axios.post('/notifications', {}).then(
        (response) => {
          console.log("sent -")
        },
        (error) => {
          if (error.response.data.message) {
            alert(error.response.data.message)
          } else {
            alert(error.response.statusText)
          }
        }
      )
    },
    startBatch () {
      console.log("start batch");
      axios.defaults.headers['X-CSRF-TOKEN'] = document.getElementsByName('csrf-token')[0].getAttribute('content')
      axios.post('/jobs', {job: {title: "huga"}}).then(
        (response) => {
          console.log("started -")
        },
        (error) => {
          if (error.response.data.message) {
            alert(error.response.data.message)
          } else {
            alert(error.response.statusText)
          }
        }
      )
    },
    search () {
      SearchStore.dispatch('search', this.searchWord)
    }
  },
  mounted() {
    console.log("mounted vue");
    this.subscribeNotifications()
  },
};
</script>
