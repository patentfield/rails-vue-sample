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
        div
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
    };
  },
  computed: {
    ...mapGetters({
      getItems: "getItems",
    }),
  },
  mounted() {
    console.log("mounted vue");
    this.$store.commit("addItem", "huga");
    console.log(this.$store.getters.getItems);
    console.log(this.getItems);
    console.log(PagesHomeStore.getters.getItems);
  },
};
</script>

<style lang="scss" scoped>
p {
  font-size: 1.5em;
  text-align: center;
}
</style>
