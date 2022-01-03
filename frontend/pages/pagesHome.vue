<template lang="pug">
#app
  #index
    h1 Index page
    v-app
      v-main
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

        div(class="mt-3")
          router-link("to"="/") No page
          router-link("to"="/page1" class="ml-2") Page1
          router-link("to"="/page2" class="ml-2") Page2
          router-view

</template>

<script>
import { mapGetters } from "vuex";
import PagesHomeStore from "../store/PagesHome.js";
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
  store: PagesHomeStore,
  data: function () {
    return {
      message1: "Hello Vue!",
      channelStatus: null,
      channelMessage: null
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
      getItems: "getItems",
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
    }
  },
  mounted() {
    console.log("mounted vue");
    this.$store.commit("addItem", "huga");
    console.log(this.$store.getters.getItems);
    console.log(this.getItems);
    console.log(PagesHomeStore.getters.getItems);
    this.subscribeNotifications()
  },
};
</script>

<style lang="scss" scoped>
p {
  font-size: 1.5em;
  text-align: center;
}
</style>
