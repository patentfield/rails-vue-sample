import PagesHeader from "../components/molecules/Header.vue";

document.addEventListener("DOMContentLoaded", () => {
  new Vue({
    el: "#pages-header",
    components: {
      PagesHeader,
    },
  });
});
