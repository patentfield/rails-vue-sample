<style lang="scss" scoped>
@import "./PagesHome.scss";
</style>

<template lang="pug">
  div
    v-app
      v-main
       router-view

</template>

<script>
import Top from "./Top.vue";

var router = new VueRouter({
  routes: [
    { path: "/", component: Top },
  ],
});

export default {
  vuetify: new Vuetify({icons: {iconfont: 'mdi'}}),
  router: router,
};

</script>
