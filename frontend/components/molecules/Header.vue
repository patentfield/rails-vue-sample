<template lang="pug">
  v-app(id="header-app")
    v-app-bar(
      dense
      flat
      fixed
      color="white"
    )
      v-app-bar-nav-icon

      v-toolbar-title
        a(href="/") Title
      v-spacer

      v-btn(icon)
        v-icon mdi-magnify

      v-btn(icon)
        v-icon mdi-heart

      v-btn(text v-if="isSignedIn")
        a(href="/users/edit") プロフィール変更
      v-btn(text v-if="isSignedIn")
        a(href="/users/sign_out" data-method="delete") ログアウト
      v-btn(text v-if="!isSignedIn")
        a(href="/users/sign_up") サインアップ
      v-btn(text v-if="!isSignedIn")
        a(href="/users/sign_in") ログイン

</template>
<script>
export default {
  vuetify: new Vuetify({icons: {iconfont: 'mdi'}}),
  data: function () {
    return {
      isSignedIn: isSignedIn,
    };
  },
};
</script>
<style lang="scss">
#header-app .v-application--wrap {
  min-height: 0px!important;
  .v-toolbar__content {
    border-bottom: #e0e0e0 solid 1px;
  }
}
</style>
