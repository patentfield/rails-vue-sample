<template lang="pug">
#page2
  h2 page 2
  p This is page 2
  .graph-wrapper
    graph(:charttype="'piechart'")

</template>

<script>
import Graph from "../components/atoms/Graph.vue";
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
