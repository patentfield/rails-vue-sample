<template lang="pug">
  v-app(id="footer-app")
    v-footer(
      color="primary lighten-1"
      padless
    )
      v-row(
        justify="center"
        no-gutters
      )
        v-btn(
          v-for="link in ['home']"
          :key="link"
          color="white"
          text
          rounded
          class="my-2"
        )
          span {{ link }}
        v-col(
          class="primary lighten-2 py-4 text-center white--text"
          cols="12"
        )
          span {{ new Date().getFullYear() }} —
          strong Vuetify
</template>
<script>
export default {
  vuetify: new Vuetify({icons: {iconfont: 'mdi'}}),
  data: function () {
    return {
      isSignedIn: isSignedIn,
    };
  },
  mounted() {
    console.log("vuetify headder");
  }
};
</script>
<style lang="scss">
#footer-app .v-application--wrap {
  min-height: 0px!important;
}
</style>
