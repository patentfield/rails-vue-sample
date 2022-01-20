<template lang="pug">
#page1
  h2 page 1
  p This is page 1
  .graph-wrapper
    graph(:charttype="'barchart'")

</template>

<script>
import Graph from "../components/Graph.vue";
export default {
  data: function () {
    return {
      message1: "Hello Vue!",
    };
  },
  components: {
   'graph': Graph
  },
};
</script>

<style lang="scss" scoped>
p {
  font-size: 3em;
  text-align: center;
}
</style>
