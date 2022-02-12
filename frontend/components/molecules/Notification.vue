<template lang="pug">
  div
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
</template>

<script>
import { mapGetters } from "vuex";

export default {
  data: function () {
    return {
      channelStatus: null,
      channelMessage: null
    }
  },
  computed: {

  },
  mounted() {
    this.subscribeNotifications();
  },
  watch: {

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
  }
};
</script>
<style lang="scss" scoped>
</style>
